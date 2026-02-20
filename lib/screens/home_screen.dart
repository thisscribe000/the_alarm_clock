import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('The Alarm Clock')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/alarm'),
              child: Text('Alarms'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/world'),
              child: Text('World Clocks'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/stopwatch'),
              child: Text('Stopwatch'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/timer'),
              child: Text('Timer'),
            ),
          ],
        ),
      ),
    );
  }
}
