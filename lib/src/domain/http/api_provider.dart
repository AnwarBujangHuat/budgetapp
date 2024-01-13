import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'api_response.dart';
import 'app_exception.dart';

enum ContentType { urlEncoded, json }

final apiProvider = Provider<ApiProvider>(
  (ref) => ApiProvider(ref),
);

class ApiProvider {
  final Duration timeout = Duration(seconds: 10);
  ApiProvider(this._ref) {
    _dio = Dio();
    _dio.options.sendTimeout = timeout;
    _dio.options.connectTimeout = timeout;
    _dio.options.receiveTimeout = timeout;

    _dio.httpClientAdapter = IOHttpClientAdapter();
  }

  final Ref _ref;

  late Dio _dio;

  late String _baseUrl;

  Future<APIResponse> post(
    String path,
    dynamic body, {
    String? newBaseUrl,
    String? token,
    Map<String, String?>? query,
    ContentType contentType = ContentType.json,
  }) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return const APIResponse.error(AppException.connectivity());
    }
    String url;
    if (newBaseUrl != null) {
      url = newBaseUrl + path;
    } else {
      url = _baseUrl + path;
    }
    var content = 'application/x-www-form-urlencoded';

    if (contentType == ContentType.json) {
      content = 'application/json';
    }

    try {
      final headers = {
        'accept': 'application/json',
        'Content-Type': content,
      };

      //Sometime for some specific endpoint it may require to use different Token
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      final response = await _dio.post(
        url,
        data: body,
        queryParameters: query,
        options: Options(validateStatus: (status) => true, headers: headers),
      );

      if (response.statusCode == null) {
        return const APIResponse.error(AppException.connectivity());
      }

      if (response.statusCode! < 300) {
        if (response.data['data'].runtimeType == List &&
                response.data['data'].isEmpty ||
            response.data["data"] == null) {
          return APIResponse.success(response.data['message']);
        } else {
          return APIResponse.success(response.data["data"]);
        }
      } else {
        if (response.statusCode! == 401) {
          return const APIResponse.error(AppException.unauthorized());
        } else if (response.statusCode! == 502) {
          return const APIResponse.error(AppException.error());
        } else if (response.statusCode == 422) {
          if (response.data['errors'] != null) {
            var firstKey = response.data['errors'].keys.toList()[0];
            return APIResponse.error(AppException.errorWithMessage(
                response.data['errors'][firstKey][0]));
          } else {
            return APIResponse.error(
                AppException.errorWithMessage(response.data['message']));
          }
        } else if (response.statusCode == 403) {
          if (response.data['data'] != null) {
            Map<String, dynamic> message = response.data['data'];
            var firstKey = message.keys.toList()[0];
            return APIResponse.error(
                AppException.errorWithMessage(message[firstKey][0]));
          } else {
            return APIResponse.error(
                AppException.errorWithMessage(response.data['message']));
          }
        } else {
          if (response.data['message'] != null) {
            return APIResponse.error(AppException.errorWithMessage(
                response.data['message'] as String));
          } else {
            return const APIResponse.error(AppException.error());
          }
        }
      }
    } on DioException catch (e) {
      if (e.error is SocketException) {
        return const APIResponse.error(AppException.connectivity());
      }
      if (e.error ==
              DioException.connectionTimeout(
                  timeout: timeout, requestOptions: RequestOptions()) ||
          e.error == DioException.receiveTimeout.runtimeType ||
          e.error == DioException.sendTimeout) {
        return const APIResponse.error(AppException.connectivity());
      }

      if (e.response != null) {
        if (e.response!.data['message'] != null) {
          return APIResponse.error(AppException.errorWithMessage(
              e.response!.data['message'] as String));
        }
      }
      return APIResponse.error(AppException.errorWithMessage(e.message!));
    } on Error catch (e) {
      return APIResponse.error(
          AppException.errorWithMessage(e.stackTrace.toString()));
    }
  }

  Future<APIResponse> get(
    String path, {
    String? newBaseUrl,
    String? token,
    Map<String, dynamic>? query,
    ContentType contentType = ContentType.json,
  }) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return const APIResponse.error(AppException.connectivity());
    }
    String url;
    if (newBaseUrl != null) {
      url = newBaseUrl + path;
    } else {
      url = _baseUrl + path;
    }

    var content = 'application/x-www-form-urlencoded';

    if (contentType == ContentType.json) {
      content = 'application/json; charset=utf-8';
    }

    final headers = {
      'accept': 'application/json',
      'Content-Type': content,
    };

    try {
      final response = await _dio.get(
        url,
        queryParameters: query,
        options: Options(validateStatus: (status) => true, headers: headers),
      );

      if (response.statusCode == null) {
        return const APIResponse.error(AppException.connectivity());
      }

      if (response.statusCode! < 300) {
        // log(response.data["data"].toString());
        // response.data.log();
        return APIResponse.success(response.data['data']);
      } else {
        if (response.statusCode! == 404) {
          return const APIResponse.error(AppException.connectivity());
        } else if (response.statusCode! == 401) {
          // _ref.read(homeProvider.notifier).logout();
          return const APIResponse.error(AppException.unauthorized());
        } else if (response.statusCode! == 502) {
          return const APIResponse.error(AppException.error());
        } else {
          if (response.data['message'] != null) {
            return APIResponse.error(AppException.errorWithMessage(
                response.data['message'] as String));
          } else {
            return const APIResponse.error(AppException.error());
          }
        }
      }
    } on DioException catch (e) {
      if (e.error is SocketException) {
        return const APIResponse.error(AppException.connectivity());
      }
      if (e.error == DioException.receiveTimeout ||
          e.error == DioException.sendTimeout) {
        return const APIResponse.error(AppException.connectivity());
      }
      return const APIResponse.error(AppException.error());
    }
  }
}
