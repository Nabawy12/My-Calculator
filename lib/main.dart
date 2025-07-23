import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatefulWidget {
  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  State<CalculatorHomePage> createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  double result = 0.0;
  double num1 = 0.0;
  double num2 = 0.0;
  String operation = '';
  String input = '';
  String show = '';

  void calculate() {
    if (operation == '+') {
      result = num1 + num2;
    } else if (operation == '-') {
      result = num1 - num2;
    } else if (operation == 'X') {
      result = num1 * num2;
    } else if (operation == '÷') {
      result = num1 / num2;
    } else if (operation == '%') {
      result = num1 % num2;
    }
    setState(() {
      input = result.toString();
      show = '';
      operation = '';
      num1 = 0.0;
      num2 = 0.0;
    });
  }

  Widget Button(String label) => Padding(
    padding: EdgeInsets.symmetric(vertical: 5.0),
    child: SizedBox(
      width: 80,
      height: 80,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            if (label == '⌫') {
              if (input.isNotEmpty) {
                input = input.substring(0, input.length - 1);
              } else if (show.isNotEmpty) {
                show = show.substring(0, show.length - 1);
              }
              if (result != 0.0) {
                result = 0.0;
                num1 = 0.0;
                num2 = 0.0;
                operation = '';
                input = '';
                show = '';
              }
            } else if (label == "AC") {
              input = '';
              show = '';
              result = 0.0;
              num1 = 0.0;
              num2 = 0.0;
              operation = '';
            } else if (label == '+/-') {
              if (input.isNotEmpty) {
                double val = double.parse(input);
                val = -val;
                input = val.toString();
              }
            } else if (label == '.') {
              if (!input.contains('.')) {
                input += label;
              }
            } else if (['+', '-', 'X', '÷', '%'].contains(label)) {
              operation = label;

              if (input.isNotEmpty) {
                num1 = double.parse(input);
                show = input + '' + label + '';
                input = '';
                result = 0.0; // Reset to avoid confusion
              } else if (result != 0.0) {
                num1 = result;
                show = result.toString() + '' + label + '';
                input = '';
                result = 0.0;
              }
            } else if (label == '=') {
              if (input.isNotEmpty) {
                num2 = double.parse(input);
                calculate();
              }
            } else {
              input += label;
            }
          });
        },
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          overlayColor: Colors.white,
          backgroundColor:
              ['AC', '=', 'X', '÷', '-', '%', '+/-', '+'].contains(label)
              ? Colors.orange.shade500
              : Colors.grey.shade500,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(24.0),
              child: Text(
                result != 0.0
                    ? result.toString()
                    : (show + input).isEmpty
                    ? '0'
                    : (show + input),
                style: TextStyle(color: Colors.white, fontSize: 48.0),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.97,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                ),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  (show + input).isEmpty ? Button('AC') : Button('⌫'),
                  Button('+/-'),
                  Button('%'),
                  Button('÷'),
                  Button('7'),
                  Button('8'),
                  Button('9'),
                  Button('X'),
                  Button('4'),
                  Button('5'),
                  Button('6'),
                  Button('-'),
                  Button('1'),
                  Button('2'),
                  Button('3'),
                  Button('+'),
                  Button('🧮'),
                  Button('0'),
                  Button('.'),
                  Button('='),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
