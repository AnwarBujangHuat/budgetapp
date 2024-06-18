// Copyright 2019 zuvola. All rights reserved.

import 'dart:async';

import 'package:budgetapp/app/app_style.dart';
import 'package:expressions/expressions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:intl/intl.dart' as intl;

import 'package:intl/intl.dart';

/// Controller for calculator.
class CalcController extends ChangeNotifier {
  final Calculator _calc;
  String _acLabel = 'AC';

  /// Create a [CalcController] with [maximumDigits] is 10 and maximumFractionDigits of [numberFormat] is 6.
  CalcController({int maximumDigits = 10})
      : _calc = Calculator(maximumDigits: maximumDigits);

  /// Create a [Calculator].
  CalcController.numberFormat(intl.NumberFormat numberFormat, int maximumDigits)
      : _calc = Calculator.numberFormat(numberFormat, maximumDigits);

  /// Display string
  String? get display => _calc.displayString as String;

  /// Display value
  double? get value => _calc.displayValue as double;

  /// Expression
  String? get expression => _calc.expression as String;

  /// Label for the "AC" button, "AC" or "C".
  String get acLabel => _acLabel;

  /// The [NumberFormat] used for display
  intl.NumberFormat get numberFormat => _calc.numberFormat;

  /// Set the value.
  void setValue(double val) {
    _calc.setValue(val);
    _acLabel = 'C';
    notifyListeners();
  }

  /// Add digit to the display.
  void addDigit(int num) {
    _calc.addDigit(num);
    _acLabel = 'C';
    notifyListeners();
  }

  /// Add a decimal point.
  void addPoint() {
    _calc.addPoint();
    _acLabel = 'C';
    notifyListeners();
  }

  /// Clear all entries.
  void allClear() {
    _calc.allClear();
    notifyListeners();
  }

  /// Clear value to zero.
  void clear() {
    _calc.clear();
    _acLabel = 'AC';
    notifyListeners();
  }

  /// Perform operations.
  void operate() {
    _calc.operate();
    _acLabel = 'AC';
    notifyListeners();
  }

  /// Remove the last digit.
  void removeDigit() {
    _calc.removeDigit();
    notifyListeners();
  }

  /// Set the operation to addition.
  void setAdditionOp() {
    _calc.setOperator('+');
    notifyListeners();
  }

  /// Set the operation to subtraction.
  void setSubtractionOp() {
    _calc.setOperator('-');
    notifyListeners();
  }

  /// Set the operation to multiplication.
  void setMultiplicationOp() {
    _calc.setOperator('×');
    notifyListeners();
  }

  /// Set the operation to division.
  void setDivisionOp() {
    _calc.setOperator('÷');
    notifyListeners();
  }

  /// Set a percent sign.
  void setPercent() {
    _calc.setPercent();
    _acLabel = 'C';
    notifyListeners();
  }

  /// Toggle between a plus sign and a minus sign.
  void toggleSign() {
    _calc.toggleSign();
    notifyListeners();
  }
}

/// Signature for callbacks that report that the [IBCalculatorWidget] value has changed.
typedef CalcChanged = void Function(
    String? key, double? value, String? expression);

/// Holds the color and typography values for the [IBCalculatorWidget].
class CalculatorThemeData {
  /// The color to use when painting the line.
  final Color? borderColor;

  /// Width of the divider border, which is usually 1.0.
  final double borderWidth;

  /// The color of the display panel background.
  final Color? displayColor;

  /// The background color of the expression area.
  final Color? expressionColor;

  /// The background color of operator buttons.
  final Color? operatorColor;

  /// The background color of command buttons.
  final Color? commandColor;

  /// The background color of number buttons.
  final Color? numColor;

  /// The text style to use for the display panel.
  final TextStyle? displayStyle;

  /// The text style to use for the expression area.
  final TextStyle? expressionStyle;

  /// The text style to use for operator buttons.
  final TextStyle? operatorStyle;

  /// The text style to use for command buttons.
  final TextStyle? commandStyle;

  /// The text style to use for number buttons.
  final TextStyle? numStyle;

  const CalculatorThemeData(
      {this.displayColor,
      this.borderWidth = 1.0,
      this.expressionColor,
      this.borderColor,
      this.operatorColor,
      this.commandColor,
      this.numColor,
      this.displayStyle,
      this.expressionStyle,
      this.operatorStyle,
      this.commandStyle,
      this.numStyle});
}

/// IBCalculatorWidget
///
/// {@tool sample}
///
/// This example shows a simple [IBCalculatorWidget].
///
/// ```dart
/// IBCalculatorWidget(
///   value: 123.45,
///   hideExpression: true,
///   onChanged: (key, value, expression) {
///     /*...*/
///   },
///   theme: const CalculatorThemeData(
///     displayColor: Colors.black,
///     displayStyle: const TextStyle(fontSize: 80, color: Colors.yellow),
///   ),
/// )
/// ```
/// {@end-tool}
///
class IBCalculatorWidget extends StatefulWidget {
  /// Visual properties for this widget.
  final CalculatorThemeData? theme;

  /// Whether to show surrounding borders.
  final bool hideSurroundingBorder;

  /// Whether to show expression area.
  final bool hideExpression;

  /// The value currently displayed on this calculator.
  final double value;

  /// Called when the button is tapped or the value is changed.
  final CalcChanged? onChanged;

  /// Called when the display area is tapped.
  final Function(double?, TapDownDetails)? onTappedDisplay;

  /// The [NumberFormat] used for display
  final intl.NumberFormat? numberFormat;

  /// Maximum number of digits on display.
  final int maximumDigits;

  /// True if this widget will be selected as the initial focus when no other
  /// node in its scope is currently focused.
  final bool autofocus;

  /// An optional focus node to use as the focus node for this widget.
  final FocusNode? focusNode;

  /// Controller for calculator.
  final CalcController? controller;

  const IBCalculatorWidget({
    super.key,
    this.theme,
    this.hideExpression = false,
    this.value = 0,
    this.onChanged,
    this.onTappedDisplay,
    this.numberFormat,
    this.maximumDigits = 10,
    this.hideSurroundingBorder = false,
    this.autofocus = false,
    this.focusNode,
    this.controller,
  });

  @override
  IBCalculatorWidgetState createState() => IBCalculatorWidgetState();
}

class IBCalculatorWidgetState extends State<IBCalculatorWidget> {
  late CalcController _controller;
  late FocusNode _focusNode;
  String? _acLabel;

  final List<String?> _nums = List.filled(10, '');

  /// This allows a value of type T or T?
  /// to be treated as a value of type T?.
  T? _ambiguate<T>(T? value) => value;

  void _handleKeyEvent(int row, int col) {
    final renderObj = context.findRenderObject();
    if (renderObj is! RenderBox) return;
    final cellW = renderObj.size.width / 3;
    final cellH = renderObj.size.height / 6;
    final pos = renderObj.localToGlobal(
        Offset(cellW * col + cellW / 2, cellH * (row + 1) + cellH / 2));
    _ambiguate(GestureBinding.instance)!
      ..handlePointerEvent(PointerDownEvent(position: pos))
      ..handlePointerEvent(PointerUpEvent(position: pos));
  }

  void _initController() {
    final controller = widget.controller;
    if (controller == null) {
      if (widget.numberFormat == null) {
        var myLocale = Localizations.localeOf(context);
        var nf = intl.NumberFormat.decimalPattern(myLocale.toLanguageTag())
          ..maximumFractionDigits = 6;
        _controller = CalcController.numberFormat(nf, widget.maximumDigits);
      } else {
        _controller = CalcController.numberFormat(
            widget.numberFormat!, widget.maximumDigits);
      }
    } else {
      _controller = controller;
    }
    _controller.addListener(_didChangeCalcValue);
  }

  @override
  void didChangeDependencies() {
    _initController();
    _focusNode = widget.focusNode ?? FocusNode();
    for (var i = 0; i < 10; i++) {
      _nums[i] = _controller.numberFormat.format(i);
    }
    _controller.allClear();
    _controller.setValue(widget.value);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(IBCalculatorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller!.removeListener(_didChangeCalcValue);
      _initController();
      _focusNode = widget.focusNode ?? FocusNode();
    }
  }

  @override
  Widget build(BuildContext context) {
    var metaKey = false;
    return Focus(
      focusNode: _focusNode,
      autofocus: widget.autofocus,
      onKeyEvent: (node, event) {
        if (event.logicalKey == LogicalKeyboardKey.tab) {
          return KeyEventResult.ignored;
        }
        if (event.logicalKey == LogicalKeyboardKey.shiftLeft ||
            event.logicalKey == LogicalKeyboardKey.shiftRight) {
          return KeyEventResult.ignored;
        }
        if (event.logicalKey == LogicalKeyboardKey.metaLeft ||
            event.logicalKey == LogicalKeyboardKey.metaRight ||
            event.logicalKey == LogicalKeyboardKey.controlLeft ||
            event.logicalKey == LogicalKeyboardKey.controlRight) {
          metaKey = event is KeyDownEvent;
          return KeyEventResult.ignored;
        }
        if (event is KeyUpEvent) {
          return KeyEventResult.ignored;
        }
        if (metaKey) {
          if (event.logicalKey == LogicalKeyboardKey.keyC) {
            final data = ClipboardData(text: _controller.value.toString());
            unawaited(Clipboard.setData(data));
            return KeyEventResult.handled;
          }
          if (event.logicalKey == LogicalKeyboardKey.keyV) {
            unawaited(Clipboard.getData('text/plain').then((value) {
              final val = double.tryParse(value?.text ?? '');
              if (val != null) {
                _controller.setValue(val);
              }
            }));
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        }
        if (event.logicalKey == LogicalKeyboardKey.keyC) {
          _handleKeyEvent(0, 0);
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.delete ||
            event.logicalKey == LogicalKeyboardKey.backspace) {
          _handleKeyEvent(0, 1);
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.percent ||
            event.character == '%') {
          _handleKeyEvent(0, 2);
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.slash ||
            event.logicalKey == LogicalKeyboardKey.numpadDivide ||
            event.character == '/') {
          _handleKeyEvent(0, 3);
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.asterisk ||
            event.logicalKey == LogicalKeyboardKey.numpadMultiply ||
            event.character == '*') {
          _handleKeyEvent(1, 3);
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.minus ||
            event.logicalKey == LogicalKeyboardKey.numpadSubtract ||
            event.character == '-') {
          _handleKeyEvent(2, 3);
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.equal ||
            event.logicalKey == LogicalKeyboardKey.enter ||
            event.logicalKey == LogicalKeyboardKey.numpadEnter ||
            event.logicalKey == LogicalKeyboardKey.numpadEqual ||
            event.character == '=') {
          _handleKeyEvent(4, 3);
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.add ||
            event.logicalKey == LogicalKeyboardKey.numpadAdd ||
            event.character == '+') {
          _handleKeyEvent(3, 3);
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.period ||
            event.logicalKey == LogicalKeyboardKey.comma ||
            event.logicalKey == LogicalKeyboardKey.numpadDecimal ||
            event.character == '.') {
          _handleKeyEvent(4, 1);
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.digit0 ||
            event.logicalKey == LogicalKeyboardKey.numpad0) {
          _handleKeyEvent(4, 0);
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.digit1 ||
            event.logicalKey == LogicalKeyboardKey.numpad1) {
          _handleKeyEvent(3, 0);
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.digit2 ||
            event.logicalKey == LogicalKeyboardKey.numpad2) {
          _handleKeyEvent(3, 1);
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.digit3 ||
            event.logicalKey == LogicalKeyboardKey.numpad3) {
          _handleKeyEvent(3, 2);
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.digit4 ||
            event.logicalKey == LogicalKeyboardKey.numpad4) {
          _handleKeyEvent(2, 0);
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.digit5 ||
            event.logicalKey == LogicalKeyboardKey.numpad5) {
          _handleKeyEvent(2, 1);
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.digit6 ||
            event.logicalKey == LogicalKeyboardKey.numpad6) {
          _handleKeyEvent(2, 2);
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.digit7 ||
            event.logicalKey == LogicalKeyboardKey.numpad7) {
          _handleKeyEvent(1, 0);
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.digit8 ||
            event.logicalKey == LogicalKeyboardKey.numpad8) {
          _handleKeyEvent(1, 1);
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.digit9 ||
            event.logicalKey == LogicalKeyboardKey.numpad9) {
          _handleKeyEvent(1, 2);
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      descendantsAreFocusable: false,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .7,
        child: GestureDetector(
          onTap: () {
            _focusNode.requestFocus();
          },
          child: Column(children: <Widget>[
            Expanded(
              child: _CalcDisplay(
                hideSurroundingBorder: widget.hideSurroundingBorder,
                hideExpression: widget.hideExpression,
                onTappedDisplay: (a, b) {
                  _focusNode.requestFocus();
                  widget.onTappedDisplay?.call(a, b);
                },
                theme: widget.theme,
                controller: _controller,
              ),
            ),
            Expanded(
                flex: 4,
                child: LayoutBuilder(
                  builder:
                      (BuildContext childContext, BoxConstraints constraints) {
                    //check if width is equal to parent width than make it 80% of parent width
                    bool isWiderThanParent =
                        (constraints.maxHeight * .8) + 10 >=
                            MediaQuery.of(context).size.width;
                    return Container(
                        width: !isWiderThanParent
                            ? constraints.maxHeight * .8
                            : constraints.maxWidth * .95,
                        child: _getButtons());
                  },
                )),
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_didChangeCalcValue);
    super.dispose();
  }

  void _didChangeCalcValue() {
    if (_acLabel == _controller.acLabel) return;
    setState(() {
      _acLabel = _controller.acLabel;
    });
  }

  void _onButtonPressed(String val) {
    _focusNode.requestFocus();
    switch (val) {
      case '→':
        _controller.removeDigit();
      case '±':
        _controller.toggleSign();
      case '+':
        _controller.setAdditionOp();
      case '-':
        _controller.setSubtractionOp();
      case '×':
        _controller.setMultiplicationOp();
      case '÷':
        _controller.setDivisionOp();
      case '=':
        _controller.operate();
      case 'AC':
        _controller.allClear();
      case 'C':
        _controller.clear();
      default:
        if (val == _controller.numberFormat.symbols.DECIMAL_SEP) {
          _controller.addPoint();
        }
        if (val == _controller.numberFormat.symbols.PERCENT) {
          _controller.setPercent();
        }
        if (_nums.contains(val)) {
          _controller.addDigit(_nums.indexOf(val));
        }
    }
    widget.onChanged?.call(val, _controller.value, _controller.expression);
  }

  Widget _getButtons() {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 20,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 6,
      ),
      itemBuilder: (context, index) {
        List<Text> button = _getTextItems();
        return TextButton(
            style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsets>(
                  EdgeInsets.zero), // Remove padding
              backgroundColor: WidgetStateProperty.all<Color>(AppColors.grey
                  .withOpacity(.1)), // Make background transparent
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                        color: Colors.grey[400]!)), // Add border side
              ),
            ),
            onPressed: () => _onButtonPressed(button[index].data ?? ''),
            child: button[index]);
      },
    );
  }

  List<Text> _getTextItems() {
    return [
      _acLabel,
      '→',
      _controller.numberFormat.symbols.PERCENT,
      '÷',
      _nums[7],
      _nums[8],
      _nums[9],
      '×',
      _nums[4],
      _nums[5],
      _nums[6],
      '-',
      _nums[1],
      _nums[2],
      _nums[3],
      '+',
      _controller.numberFormat.symbols.DECIMAL_SEP,
      _nums[0],
      '±',
      '='
    ].map((title) {
      TextStyle? style = Theme.of(context).textTheme.titleMedium;
      if (title == '=' ||
          title == '+' ||
          title == '-' ||
          title == '×' ||
          title == '÷') {
        style = style!.copyWith(fontSize: FontSize.largeTitle);
      }
      if (title == _controller.numberFormat.symbols.PERCENT ||
          title == '→' ||
          title == 'C' ||
          title == 'AC') {
        style = style;
      }
      return Text(
        title ?? '',
        style: style,
      );
    }).toList();
  }
}

class _CalcDisplay extends StatefulWidget {
  /// Whether to show surrounding borders.
  final bool? hideSurroundingBorder;

  /// Whether to show expression area.
  final bool? hideExpression;

  /// Visual properties for this widget.
  final CalculatorThemeData? theme;

  /// Controller for calculator.
  final CalcController controller;

  /// Called when the display area is tapped.
  final Function(double?, TapDownDetails)? onTappedDisplay;

  const _CalcDisplay({
    required this.onTappedDisplay,
    required this.controller,
    this.hideSurroundingBorder,
    this.hideExpression,
    this.theme,
  });

  @override
  _CalcDisplayState createState() => _CalcDisplayState();
}

class _CalcDisplayState extends State<_CalcDisplay> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_didChangeCalcValue);
  }

  @override
  void didUpdateWidget(_CalcDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_didChangeCalcValue);
      widget.controller.addListener(_didChangeCalcValue);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_didChangeCalcValue);
    super.dispose();
  }

  void _didChangeCalcValue() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final borderSide = Divider.createBorderSide(
      context,
      color: widget.theme?.borderColor ?? Theme.of(context).dividerColor,
      width: widget.theme?.borderWidth ?? 1.0,
    );
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: widget.hideSurroundingBorder! ? BorderSide.none : borderSide,
          left: widget.hideSurroundingBorder! ? BorderSide.none : borderSide,
          right: widget.hideSurroundingBorder! ? BorderSide.none : borderSide,
          bottom: widget.hideSurroundingBorder! ? borderSide : BorderSide.none,
        ),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTapDown: (details) => widget.onTappedDisplay == null
                  ? null
                  : widget.onTappedDisplay!(widget.controller.value, details),
              child: Container(
                color: widget.theme?.displayColor,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      widget.controller.display!,
                      style: widget.theme?.displayStyle ??
                          const TextStyle(fontSize: 50),
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: !widget.hideExpression!,
            child: Expanded(
              child: Container(
                color: widget.theme?.expressionColor,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Text(
                      widget.controller.expression!,
                      style: widget.theme?.expressionStyle ??
                          const TextStyle(color: Colors.grey),
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Display value for the [Calculator].
class CalcDisplay {
  String string = '';
  double value = 0;

  /// The [NumberFormat] used for display
  final NumberFormat numberFormat;

  /// Maximum number of digits on display.
  final int maximumDigits;

  CalcDisplay(this.numberFormat, this.maximumDigits) {
    clear();
  }

  /// Add a digit to the display.
  void addDigit(int digit) {
    var reg = RegExp(
        '[${numberFormat.symbols.GROUP_SEP}${numberFormat.symbols.DECIMAL_SEP}]');
    if (string.replaceAll(reg, '').length >= maximumDigits) {
      return;
    }
    if (string == numberFormat.symbols.ZERO_DIGIT) {
      string = numberFormat.format(digit);
    } else {
      string += numberFormat.format(digit);
    }
    _reformat();
  }

  /// Add a decimal point.
  void addPoint() {
    if (string.contains(numberFormat.symbols.DECIMAL_SEP)) {
      return;
    }
    string += numberFormat.symbols.DECIMAL_SEP;
  }

  /// Clear value to zero.
  void clear() {
    string = numberFormat.symbols.ZERO_DIGIT;
    value = 0;
  }

  /// Remove the last digit.
  void removeDigit() {
    if (string.length == 1 ||
        (string.startsWith(numberFormat.symbols.MINUS_SIGN) &&
            string.length == 2)) {
      clear();
    } else {
      string = string.substring(0, string.length - 1);
      _reformat();
    }
  }

  /// Set the value.
  void setValue(double val) {
    value = val;
    string = numberFormat.format(val);
  }

  /// Toggle between a plus sign and a minus sign.
  void toggleSign() {
    if (value <= 0) {
      string = string.replaceFirst(numberFormat.symbols.MINUS_SIGN, '');
    } else {
      string = numberFormat.symbols.MINUS_SIGN + string;
    }
    _reformat();
  }

  /// Check the validity of the displayed value.
  bool validValue() {
    return !(string == numberFormat.symbols.NAN ||
        string == numberFormat.symbols.INFINITY);
  }

  void _reformat() {
    value = numberFormat.parse(string) as double;
    if (!string.contains(numberFormat.symbols.DECIMAL_SEP)) {
      string = numberFormat.format(value);
    }
  }
}

/// Expression for the [Calculator].
class CalcExpression {
  final ExpressionEvaluator evaluator = const ExpressionEvaluator();
  final String zeroDigit;

  String value = '';
  String internal = '';
  String? _op;
  String? _right;
  String? _rightInternal;
  String? _left;
  String? _lefInternal;

  /// Create a [CalcExpression] with [zeroDigit].
  CalcExpression({this.zeroDigit = '0'});

  void clear() {
    value = '';
    internal = '';
    _op = null;
    _right = null;
    _left = null;
    _lefInternal = null;
    _rightInternal = null;
  }

  bool needClearDisplay() {
    return _op != null && _right == null;
  }

  /// Perform operations.
  num operate() {
    try {
      return evaluator.eval(Expression.parse(internal), {}) as num;
    } on Exception {
      //
    }
    return double.nan;
  }

  void repeat(CalcDisplay val) {
    if (_right != null) {
      _left = value = val.string;
      _lefInternal = internal = val.value.toString();
      value = '$_left $_op $_right';
      internal = '$_lefInternal${_convertOperator()}$_rightInternal';
      val.setValue(operate().toDouble());
    }
  }

  /// Set the operation. The [op] must be either +, -, ×, or ÷.
  void setOperator(String op) {
    _left ??= _lefInternal = zeroDigit;
    if (_right != null) {
      _left = '$_left $_op $_right';
      _lefInternal = '$_lefInternal${_convertOperator()}$_rightInternal';
      _right = _rightInternal = null;
    }
    _op = op;
    value = '$_left $_op ?';
  }

  /// Set percent value. The [string] is a string representation and [percent] is a value.
  double setPercent(String string, double percent) {
    double? base = 1.0;
    if (_op == '+' || _op == '-') {
      base = evaluator.eval(Expression.parse(_lefInternal!), {}) as double;
    }
    var val = base * percent / 100;
    if (_op == null) {
      _left = value = string;
      _lefInternal = internal = val.toString();
      return val;
    } else {
      _right = string;
      _rightInternal = val.toString();
      value = '$_left $_op $_right';
      internal = '$_lefInternal${_convertOperator()}$val';
      return val;
    }
  }

  /// Set value with [CalcDisplay].
  void setVal(CalcDisplay val) {
    if (_op == null) {
      _left = value = val.string;
      _lefInternal = internal = val.value.toString();
    } else {
      _right = val.string;
      _rightInternal = val.value.toString();
      value = '$_left $_op $_right';
      internal = '$_lefInternal${_convertOperator()}$_rightInternal';
    }
  }

  String _convertOperator() {
    return _op!.replaceFirst('×', '*').replaceFirst('÷', '/');
  }
}

/// Calculator
class Calculator {
  final CalcExpression _expression;
  final CalcDisplay _display;
  bool _operated = false;

  /// The [NumberFormat] used for display
  final NumberFormat numberFormat;

  /// Maximum number of digits on display.
  final int maximumDigits;

  /// Create a [Calculator] with [maximumDigits] is 10 and maximumFractionDigits of [numberFormat] is 6.
  Calculator({int maximumDigits = 10})
      : this.numberFormat(
            NumberFormat()..maximumFractionDigits = 6, maximumDigits);

  /// Create a [Calculator].
  Calculator.numberFormat(this.numberFormat, this.maximumDigits)
      : _expression =
            CalcExpression(zeroDigit: numberFormat.symbols.ZERO_DIGIT),
        _display = CalcDisplay(numberFormat, maximumDigits);

  /// Display string
  get displayString => _display.string;

  /// Display value
  get displayValue => _display.value;

  /// Expression
  get expression => _expression.value;

  /// Set the value.
  void setValue(double val) {
    _display.setValue(val);
    _expression.setVal(_display);
  }

  /// Add a digit to the display.
  void addDigit(int digit) {
    if (!_display.validValue()) {
      return;
    }
    if (_expression.needClearDisplay()) {
      _display.clear();
    }
    if (_operated) {
      allClear();
    }
    _display.addDigit(digit);
    _expression.setVal(_display);
  }

  /// Add a decimal point.
  void addPoint() {
    if (!_display.validValue()) {
      return;
    }
    if (_expression.needClearDisplay()) {
      _display.clear();
    }
    if (_operated) {
      allClear();
    }
    _display.addPoint();
    _expression.setVal(_display);
  }

  /// Clear all entries.
  void allClear() {
    _expression.clear();
    _display.clear();
    _expression.setVal(_display);
    _operated = false;
  }

  /// Clear last entry.
  void clear() {
    _display.clear();
    _expression.setVal(_display);
  }

  /// Perform operations.
  void operate() {
    if (!_display.validValue()) {
      return;
    }
    if (_operated) {
      _expression.repeat(_display);
    } else {
      _display.setValue(_expression.operate().toDouble());
    }
    _operated = true;
  }

  /// Remove the last digit.
  void removeDigit() {
    if (_check()) return;
    _display.removeDigit();
    _expression.setVal(_display);
  }

  /// Set the operation. The [op] must be either +, -, ×, or ÷.
  void setOperator(String op) {
    if (_check()) return;
    _expression.setOperator(op);
    if (op == '+' || op == '-') {
      operate();
      _operated = false;
    }
  }

  /// Set a percent sign.
  void setPercent() {
    if (_check()) return;
    var string = _display.string + numberFormat.symbols.PERCENT;
    var val = _expression.setPercent(string, _display.value);
    _display.setValue(val);
  }

  /// Toggle between a plus sign and a minus sign.
  void toggleSign() {
    if (_check()) return;
    _display.toggleSign();
    _expression.setVal(_display);
  }

  ///
  bool _check() {
    if (!_display.validValue()) {
      return true;
    }
    if (_operated) {
      _expression.clear();
      _expression.setVal(_display);
      _operated = false;
    }
    return false;
  }
}
