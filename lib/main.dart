import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: MySimpleWidget(),
        ),
      ),
    );
  }
}

class MySimpleWidget extends StatefulWidget {
  const MySimpleWidget({super.key});

  @override
  State<MySimpleWidget> createState() => _MySimpleWidgetState();
}

class _MySimpleWidgetState extends State<MySimpleWidget> {
  String _text = 'Нажми меня';

  void _changeText() {
    setState(() {
      _text = 'Молодец';
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _changeText,
      child: Text(_text),
    );
  }
}