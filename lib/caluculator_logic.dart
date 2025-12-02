// 電卓の計算処理だけをまとめたクラス。
// UI（ボタンや画面表示）と切り離すことで、コードが読みやすくなり、
// あとでテストも書きやすくなります。
class CalculatorLogic {
  // 現在入力中の数字を文字列として保持します。
  // 例：ユーザーが「1 → 2 → 3」と押したら "123" になります。
  String _currentInput = '0';

  // 最初の数字（例：12 + の「12」）
  double? _firstOperand;

  // 現在選択されている演算子（+ - × ÷）
  String? _operator;

  // 外から現在の入力値を読み取れるようにする getter。
  // getter は「値を取り出すための特別な関数」と覚えてOK。
  String get displayValue => _currentInput;


  // 数字ボタンが押されたときの処理。
  // 例：pressNumber("5") → 現在の入力が「5」「15」「215」…と変わる。
  void pressNumber(String digit) {
    // 最初が "0" の状態で数字が押されたら置き換える。
    if (_currentInput == '0') {
      _currentInput = digit;
    } else {
      // すでに数字があるなら後ろに追加していく（文字列として連結）。
      _currentInput += digit;
    }
  }


  // 演算子（+ - × ÷）が押されたときの処理。
  void pressOperator(String operator) {
    // 現在の入力値を double に変換して firstOperand に保存。
    // 例：12 + のときの「12」
    _firstOperand = double.tryParse(_currentInput);

    // 押された演算子（+ - × ÷）を保存。
    _operator = operator;

    // 次の数字入力に備えて currentInput をリセット。
    _currentInput = '0';
  }


  // = が押されたときの処理。
  String calculateResult() {
    // 演算子がまだ押されていない場合は計算できないので、そのまま返す。
    if (_firstOperand == null || _operator == null) {
      return _currentInput;
    }

    // secondOperand = 新しく入力した数字（例：12 + 34 の「34」）
    final secondOperand = double.tryParse(_currentInput);

    // 計算結果を保持する変数。
    double result = 0;

    // 演算子ごとに処理を分ける。
    switch (_operator) {
      case '+':
        result = _firstOperand! + secondOperand!;
        break;
      case '-':
        result = _firstOperand! - secondOperand!;
        break;
      case '×':
        result = _firstOperand! * secondOperand!;
        break;
      case '÷':
      // 0 で割ろうとした場合のガード
        if (secondOperand == 0) {
          return 'Error';
        }
        result = _firstOperand! / secondOperand!;
        break;
    }

    // 計算後、結果を currentInput にセットし、
    // 次の計算のため firstOperand と operator をリセット。
    _currentInput = result.toString();
    _firstOperand = null;
    _operator = null;

    // 画面に表示するため、結果の文字列を返す。
    return _currentInput;
  }


  // AC（リセット）が押されたときの処理。
  void clear() {
    _currentInput = '0';
    _firstOperand = null;
    _operator = null;
  }
}
