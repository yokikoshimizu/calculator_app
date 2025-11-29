// lib/calculator_page.dart
import 'package:flutter/material.dart';
import 'calculator_button.dart';
import 'calculator_logic.dart';

/// 電卓画面全体のWidget
class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _calculator = CalculatorLogic();

  void _onButtonPressed(String value) {
    setState(() {
      _calculator.press(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    // ボタンの配置
    final buttonLabels = [
      ['AC', '÷'],
      ['7', '8', '9', '×'],
      ['4', '5', '6', '-'],
      ['1', '2', '3', '+'],
      ['0', '.', '='],
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // 上の表示部分
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.bottomRight,
                child: Text(
                  _calculator.display,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 64,
                    fontWeight: FontWeight.w200,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            // 下のボタン部分
            ...buttonLabels.map((row) {
              return Row(
                children: row.map((label) {
                  final isZero = label == '0';
                  return CalculatorButton(
                    label: label,
                    flex: isZero ? 2 : 1, // 0だけ横長に
                    onTap: () => _onButtonPressed(label),
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
