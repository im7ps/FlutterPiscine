import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '42 Flutter ex00.1',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 91, 6, 238)),
        useMaterial3: true,
      ),
      home: const ButtonPage(),
    );
  }
}

class _ButtonPageState extends State<ButtonPage> {
  final List<String>_homeText = ["Hello world!", "A simple text"];
  int count = 0;

  void _buttonHandler() {
    debugPrint("Button pressed!");

    setState( () {
      count++;
    } );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 65, 87, 255),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultTextStyle(
              style: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 42,
                ),
              child: Text(
              _homeText[count % 2],
              )
            ),
            TextButton(
              onPressed: _buttonHandler, 
              
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.lightGreenAccent),
                ),
             
              child: const Text('Click me'),
              ),
          ],
        )
      )
    );
  }
  }

class ButtonPage extends StatefulWidget {
  const ButtonPage({super.key});

  @override
  State<ButtonPage> createState() => _ButtonPageState();
}
