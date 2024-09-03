// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transactionTypeNotifierHash() =>
    r'089fcc73247dfba11956a4b794c31c0e5e1858a7';

/// See also [TransactionTypeNotifier].
@ProviderFor(TransactionTypeNotifier)
final transactionTypeNotifierProvider = AutoDisposeNotifierProvider<
    TransactionTypeNotifier, TransactionType>.internal(
  TransactionTypeNotifier.new,
  name: r'transactionTypeNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transactionTypeNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TransactionTypeNotifier = AutoDisposeNotifier<TransactionType>;
String _$dashboardTransactionListHash() =>
    r'7fd271775aa8042796aeff268187711879614084';

/// See also [DashboardTransactionList].
@ProviderFor(DashboardTransactionList)
final dashboardTransactionListProvider = AutoDisposeAsyncNotifierProvider<
    DashboardTransactionList, List<TransactionModel>>.internal(
  DashboardTransactionList.new,
  name: r'dashboardTransactionListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dashboardTransactionListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DashboardTransactionList
    = AutoDisposeAsyncNotifier<List<TransactionModel>>;
String _$transactionDurationNotifierHash() =>
    r'dd557589c91474a880dea9de5a670a559fa314af';

/// See also [TransactionDurationNotifier].
@ProviderFor(TransactionDurationNotifier)
final transactionDurationNotifierProvider = AutoDisposeNotifierProvider<
    TransactionDurationNotifier, TransactionDuration>.internal(
  TransactionDurationNotifier.new,
  name: r'transactionDurationNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transactionDurationNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TransactionDurationNotifier
    = AutoDisposeNotifier<TransactionDuration>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
