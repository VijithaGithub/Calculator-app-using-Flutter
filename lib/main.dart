import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator App',
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String display = '';

  void onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        display = '';
      } else if (value == '=') {
        try {
          display = evaluate(display).toString();
        } catch (e) {
          display = 'Error';
        }
      } else {
        display += value;
      }
    });
  }

  double evaluate(String expr) {
    // Supports +, -, *, /
    List<String> parts = expr.split(RegExp(r'([+\-*/])'));
    List<String> operators = RegExp(r'[+\-*/]')
        .allMatches(expr)
        .map((m) => m.group(0)!)
        .toList();

    double result = double.parse(parts[0]);
    for (int i = 0; i < operators.length; i++) {
      double num = double.parse(parts[i + 1]);
      switch (operators[i]) {
        case '+':
          result += num;
          break;
        case '-':
          result -= num;
          break;
        case '*':
          result *= num;
          break;
        case '/':
          result /= num;
          break;
      }
    }
    return result;
  }

  Widget buildButton(String label) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => onButtonPressed(label),
          child: Text(label, style: const TextStyle(fontSize: 24)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator App')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(display, style: const TextStyle(fontSize: 40)),
            ),
          ),
          Row(children: ['7', '8', '9', '/'].map(buildButton).toList()),
          Row(children: ['4', '5', '6', '*'].map(buildButton).toList()),
          Row(children: ['1', '2', '3', '-'].map(buildButton).toList()),
          Row(children: ['C', '0', '=', '+'].map(buildButton).toList()),
        ],
      ),
    );
  }
}
