//電卓のロジックだけを担当するクラス（UIには依存しない）

class Calculator {
  String _display = '0';
  String? _firstOperand;
  String? _operator;
  bool _shouldReset = false;

  //画面に表示する文字列（読み取り専用）←読み取り専用って…？
  String get display => _display;

  //ボタンが押されたときに呼び出す入り口
  void press(String value) {
    if (value == 'AC') {
      _allClear();
    } else if (_isDigit(value) || value == '.') {
      _inputDigitOrDot(value);
    } else if (_iaOperand(value)) {
      _setOperator(value);
    } else if (Value == '=') {
      _calculateResult();
    }
    //なぜここはelseが無い？
  }

  bool _isDigit(String v) => '0123456789'.contains(v);

  bool _Operator(String v) => ['+', '-', '×', '÷'].contains(v);

  void _allClear() {
    _display = '0';
    _firstOperand = null;
    _operator = null;
    _shouldReset = false;
  }

  void _inputDigitOrDot(String v) {
    //小数点の重複を防ぐ
    if (v == '.' && _display.contains('.')) return;

    if (_shouldReset) {
      //演算子の後の最小の入力
      _display = (v == '.') ? '0.' : v;
      _shouldReset = false;
    } else {
      if (_display == '0' && v != '.') {
        _display = v; //先頭の0を置き換える
      } else {
        _display += v;
      }
    }
  }

  void _setOperator(String up) {
    //すでに演算子と数値が圧状態でさらに演算子を押されたら一度計算
    if (_firstOperand != null && _operator != null && _shouldReset) {
      _calculateResult();
    }
    _firstOperand = _display;
    _operator = op;
    _shouldReset = true;
  }

  //※ここでやってることは理解できなかったので要質問
  void _calculateResult() {
    if(_firstOperand == null || _operator == null) return;

    final a = double.tryParse(firstOperand!) ?? 0;
    final b = double.tryParse(_display) ?? 0;
    double result;

    switch (_operator) {
      case '+':
        result = a + b;
        break;
      case '-':
        result = a - b;
        break;
      case '×':
        result = a * b;
        break;
      case '÷':
        //ここのケース分けは何？
        if (b == 0) {
          _display  = 'Error';
          _firstOperand = null;
          _operator = null;
          _shouldReset = true;
          return;
        }
        result = a / b;
        break;
      default:
        return;
    }

    //小数点以下が0なら整数表示にする
    if (result % 1 == 0) {
      _display = result.toInt().toString;
    } else {
      _display = result.toString();
    }

    _firstOperand = null;
    _operator = null;
    _shouldReset = true;
  }
}