import 'package:flutter/material.dart';
// さっき作った「ボタン1個分の部品」を使うための import。
import 'calculator_button.dart';
// さっき作った「計算だけ担当するロジック」を使うための import。
import 'calculator_logic.dart';
import 'caluculator_logic.dart';


// 電卓の「画面全体」を表すウィジェット。
// StatefulWidget = 「状態（数字や演算子）を持つ画面」という意味。
class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  // ↑ const = 「このウィジェット自体は変わらないよ」というヒント。
  // super.key = 親クラスに key をそのまま渡すお約束。

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
// ↑ 画面の「状態」を管理する _CalculatorPageState を作る。
}


// 実際に状態（表示中の数字など）と UI を持つクラス。
// ここで setState() を使って「画面を更新する」ことができます。
class _CalculatorPageState extends State<CalculatorPage> {
  // 計算ロジックのクラス。ここに「数字を押した」「+ を押した」などを伝える。
  final CalculatorLogic _logic = CalculatorLogic();

  // 画面に表示する文字列。最初は「0」からスタート。
  String _displayText = '0';

  // 画面が最初に作られたときに1回だけ呼ばれるメソッド。
  // ここで初期表示をロジックから取得しておきます。
  @override
  void initState() {
    super.initState();
    // ロジック側の現在値（"0"）を取得して表示用にセット。
    _displayText = _logic.displayValue;
  }

  // ボタンが押されたときに呼ばれる共通処理。
  // どのボタンが押されたか（label）によって挙動を変えます。
  void _onButtonPressed(String label) {
    setState(() {
      // 数字かどうかを判定
      if (_isDigit(label)) {
        // 数字なら「数字入力メソッド」を呼ぶ
        _logic.pressNumber(label);
      }
      // 演算子かどうか
      else if (_isOperator(label)) {
        // 演算子なら「演算子入力メソッド」を呼ぶ
        _logic.pressOperator(label);
      }
      // "＝" が押されたとき
      else if (label == '=') {
        // 結果を計算する。戻り値は文字列だが、
        // ここでは _logic.displayValue をあとで読むので特に変数に入れなくてもOK。
        _logic.calculateResult();
      }
      // "AC" が押されたとき
      else if (label == 'AC') {
        // すべてリセット
        _logic.clear();
      }

      // 上のどれかの処理をしたあとで、
      // ロジック側の現在値を取り出して画面表示用の変数に反映します。
      _displayText = _logic.displayValue;
    });
    // setState(...) の中で _displayText を変更すると、
    // build() が呼び直されて、画面の Text が更新されます。
  }

  // 数字かどうかを判定するヘルパーメソッド。
  bool _isDigit(String label) {
    // "0123456789" の中に label が含まれていれば true。
    return '0123456789'.contains(label);
  }

  // 演算子かどうかを判定するヘルパーメソッド。
  bool _isOperator(String label) {
    // +, -, ×, ÷ のいずれかなら true。
    return ['+', '-', '×', '÷'].contains(label);
  }

  // ここが「画面の見た目」を作るメソッド。
  // Flutter は build() の戻り値（Widget）を画面に描画します。
  @override
  Widget build(BuildContext context) {
    // 電卓のボタンを行ごとに並べるための「ラベルの二次元リスト」。
    // 後でこれを map して Row と CalculatorButton に変換します。
    final List<List<String>> buttonRows = [
      ['AC', '÷'],
      ['7', '8', '9', '×'],
      ['4', '5', '6', '-'],
      ['1', '2', '3', '+'],
      ['0', '='],
    ];

    // Scaffold は「画面の基本レイアウト」を提供するウィジェット。
    // appBar, body, floatingActionButton などを簡単に配置できます。
    return Scaffold(
      // 背景色を黒に（電卓っぽく）
      backgroundColor: Colors.black,
      // SafeArea はノッチ（黒い切り欠き）やステータスバーを避けて表示するためのもの。
      body: SafeArea(
        // Column = 縦にウィジェットを並べるレイアウト。
        child: Column(
          children: [
            // 上半分くらいを「表示部分」として使う。
            Expanded(
              // Expanded は残りの空間を埋めるように広がるウィジェット。
              child: Container(
                // 画面の左右上下に余白を取る
                padding: const EdgeInsets.all(16),
                // 表示するテキストを右下に寄せる（電卓っぽいレイアウト）
                alignment: Alignment.bottomRight,
                // 実際に数字を表示する Text ウィジェット
                child: Text(
                  _displayText, // ← さっきの _displayText を表示
                  style: const TextStyle(
                    color: Colors.white,   // 文字色は白
                    fontSize: 64,          // 大きめの数字表示
                    fontWeight: FontWeight.w200, // 少し細めのフォント
                  ),
                  maxLines: 1,                    // 1行だけ表示
                  overflow: TextOverflow.ellipsis, // はみ出したら「…」で省略
                ),
              ),
            ),
            // ここから下がボタン部分。
            // buttonRows の中身（各行）を Row に変換していきます。
            ...buttonRows.map((row) {
              // 1行分のボタンを横並び（Row）にする
              return Row(
                children: row.map((label) {
                  // "0" だけ横長にしたいので flex を変える
                  final bool isZero = label == '0';

                  return CalculatorButton(
                    label: label,         // ボタンに表示する文字
                    flex: isZero ? 2 : 1, // "0" だけ幅2倍、それ以外は1
                    onTap: () {
                      // そのボタンが押されたときにどうするか
                      _onButtonPressed(label);
                    },
                  );
                }).toList(),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
