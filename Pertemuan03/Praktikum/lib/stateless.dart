import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: Column(
          children: [
            Center(
              child: Text('Arif banyak dosa'),
            ),
            ElevatedButton(
              onPressed: () {
                int counter = 0;
                counter++;
              },
              child: Text('+ 1 dosa'),
            ),
          ],
        ),
      ),
      theme: ThemeData.dark()
    );
  }
}