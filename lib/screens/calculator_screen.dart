import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  String _operand1 = '';
  String _operator = '';
  String _operand2 = '';

  final List<String> _buttons = [
    'C',
    '+/-',
    '%',
    '/',
    '7',
    '8',
    '9',
    'X',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    '=',
  ];

  void _onButtonPressed(String text) {
    setState(() {
      if (text == 'C') {
        _clear();
      } else if (text == '+/-') {
        _toggleSign();
      } else if (text == '%') {
        _calculatePercentage();
      } else if (['/', 'X', '-', '+'].contains(text)) {
        _setOperator(text);
      } else if (text == '=') {
        _calculateResult();
      } else {
        _appendNumber(text);
      }
    });
  }

  void _appendNumber(String text) {
    if (text == '.' && _display.contains('.')) return;

    if (_operator.isEmpty) {
      if (_display == '0' && text != '.') {
        _display = text;
      } else {
        _display += text;
      }
      _operand1 = _display;
    } else {
      if (_operand2.isEmpty || _display == _operand1) {
        _display = text;
      } else {
        _display += text;
      }
      _operand2 = _display;
    }
  }

  void _setOperator(String text) {
    if (_operand1.isNotEmpty) {
      _operator = text;
    }
  }

  void _clear() {
    _display = '0';
    _operand1 = '';
    _operator = '';
    _operand2 = '';
  }

  void _toggleSign() {
    if (_display != '0') {
      if (_display.startsWith('-')) {
        _display = _display.substring(1);
      } else {
        _display = '-$_display';
      }
      if (_operator.isEmpty) {
        _operand1 = _display;
      } else {
        _operand2 = _display;
      }
    }
  }

  void _calculatePercentage() {
    if (_display != '0') {
      double number = double.parse(_display) / 100;
      _display = number.toString();
      if (_operator.isEmpty) {
        _operand1 = _display;
      } else {
        _operand2 = _display;
      }
    }
  }

  void _calculateResult() {
    if (_operand1.isEmpty || _operator.isEmpty || _operand2.isEmpty) return;

    double num1 = double.parse(_operand1);
    double num2 = double.parse(_operand2);
    double result = 0.0;

    switch (_operator) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case 'X':
        result = num1 * num2;
        break;
      case '/':
        if (num2 == 0) {
          _display = 'Error';
          _clear();
          return;
        }
        result = num1 / num2;
        break;
    }

    _display = result.toString();
    if (_display.endsWith('.0')) {
      _display = _display.substring(0, _display.length - 2);
    }
    _operand1 = _display;
    _operator = '';
    _operand2 = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator') ,
      ),
    
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(20),
                child: Text(
                  _display,
                  style: const TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 119, 118, 118),
                  ),
                ),
              ),
            ),
            Expanded(flex: 3, child: _buildButtonGrid()),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonGrid() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        itemCount: _buttons.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 20,
          mainAxisSpacing: 4,
        ),
        itemBuilder: (context, index) {
          final text = _buttons[index];
          return _buildButton(text);
        },
      ),
    );
  }

  Widget _buildButton(String text) {
    bool isOperator = ['/', 'X', '-', '+', '='].contains(text);
    bool isAction = ['C', '+/-', '%'].contains(text);

    Color bgColor = const Color.fromARGB(255, 81, 144, 173);
    Color textColor = Colors.white;

    return ElevatedButton(
      onPressed: () => _onButtonPressed(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
