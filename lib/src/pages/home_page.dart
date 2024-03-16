import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chit Chat Pro'),),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(child: Center(child: Text('Prompt Field'))),
            TextField(
              decoration: InputDecoration(hintText: 'Hint Text'),
            )
          ],
        ),
      ),
    );
  }
}