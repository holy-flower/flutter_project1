import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Продольнова Жанна Сергеевна',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
            ),

            SizedBox(height: 20),

            Text(
              'ИКБО-11-22',
              style: TextStyle(fontSize: 18),
            ),

            SizedBox(height: 20),

            Text(
              '22И0394',
              style: TextStyle(fontSize: 18),
            ),
            ElevatedButton(onPressed: null, child: const Text("Кнопка"),
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.cyan),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
            ),
              fixedSize: MaterialStateProperty.all(Size(200, 50))
            )
            )
          ],
        ),
      ),
    );
  }
}
