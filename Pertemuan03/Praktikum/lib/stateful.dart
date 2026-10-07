import 'package:flutter/material.dart';

void main() => runApp(const MyStateful());

class MyStateful extends StatefulWidget {
  const MyStateful({super.key});

  @override
  State<MyStateful> createState() => _MyStatefulState();
}

class _MyStatefulState extends State<MyStateful> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('ARIF BANYAK BERDOA'),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    counter--;
                  });
                },
                child: const Text('- 1 dosa'),
              ),
              Text('ARIF BANYAK DOSA'),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    counter++;
                  });
                },
                child: const Text('+ 1 dosa'),
              ),
              Text('Total dosa: $counter'),
            ],
          ),
        ),
      ),
    );
  }
}