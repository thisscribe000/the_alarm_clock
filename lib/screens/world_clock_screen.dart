import 'package:flutter/material.dart';

class WorldClockScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('World Clocks')),
      body: Center(child: Text('Add clocks from other cities — paste your UI here')),
    );
  }
}
