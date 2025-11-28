import 'package:flutter/material.dart';

//ボタン1つ分のウィジェット
class CalculatorButton extends StatelessWidget {
  final String label; //ボタンに表示する文字
  final int flex; //横幅（0だけ2倍にしたい用）
  final voidCallBack onTap; //押されたときに実行する処理

  //ここで何をやってるかがわからないので質問
  const CalculatorButton({
    super.key,
    required this.label,
    this.flex = 1,
    required this.onTap,
  });

  //演算子ボタンかどうか
  bool get _isOperator => ['+', '-', '×', '÷', '=', 'AC'].contains(label);

  //ここからも何をやってるかがよくわからない（ウィジェット自体はわかる）
  @override
  Widgwt build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SizedBox(
          height: 72,
          child: EvaluatedButton(
            style: EvaluatedButton.stylefrom(
              backgroundColor:
                _isOperator ? Colors.orange : const Color(0xFF333333),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36),
              ),
            ),
            onPressed: onTap,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}