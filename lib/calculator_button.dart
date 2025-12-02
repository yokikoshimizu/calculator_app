import 'package:flutter/material.dart';

// 1つの電卓ボタンを表すカスタムウィジェット。
// この Widget を使えば、「見た目」「押したときの処理」をまとめられるので
// 電卓画面がスッキリ読みやすくなります。
class CalculatorButton extends StatelessWidget {
  // ボタンのラベル（例：1, 2, +, AC など）
  final String label;

  // ボタンの横方向の広がりを指定する flex（1だと普通の大きさ）
  // 例えば "0" を横長にしたいときに flex を 2 にして使う。
  final int flex;

  // ボタンが押されたときに呼ばれるコールバック関数。
  // UI とロジックを分離するため、ロジックは外側から受け取る。
  final VoidCallback onTap;

  // コンストラクタ
  const CalculatorButton({
    super.key,
    required this.label,  // ボタンに表示する文字
    this.flex = 1,        // デフォルトは 1（普通サイズ）
    required this.onTap,  // 押したときの関数を必ず渡す
  });

  // getter（ゲッター）
  // 「このボタンが演算子かどうか」を調べたい時に使う。
  // ['+', '-', '×', '÷', '=', 'AC'] のどれかと一致したら true。
  bool get _isOperator => ['+', '-', '×', '÷', '=', 'AC'].contains(label);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // Expanded は Row や Column の中で「空いている幅いっぱいに広げる」Widget。
      // flex が 2 のときは通常の2倍の幅になる（0 を横長にしたいとき等に使える）
      flex: flex,
      child: Padding(
        // ボタン同士の間に余白を入れる
        padding: const EdgeInsets.all(4.0),
        child: SizedBox(
          // ボタンの高さを統一（72 は電卓っぽいサイズ）
          height: 72,
          child: ElevatedButton(
            // ボタンの見た目の設定
            style: ElevatedButton.styleFrom(
              // _isOperator が true（演算子ボタン）ならオレンジ色
              // false（数字ボタン）なら濃いグレーにする
              backgroundColor:
              _isOperator ? Colors.orange : const Color(0xFF333333),
              // テキストは白色
              foregroundColor: Colors.white,
              // 丸型にする
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36),
              ),
            ),

            // ボタンが押されたときの処理（外側から渡された関数を実行）
            onPressed: onTap,

            // ボタンに表示される文字
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 24,  // ボタン文字の大きさ
              ),
            ),
          ),
        ),
      ),
    );
  }
}
