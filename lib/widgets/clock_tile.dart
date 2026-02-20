import 'package:flutter/material.dart';

class ClockTile extends StatelessWidget {
  final String city;
  final DateTime time;

  const ClockTile({required this.city, required this.time});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(city),
      subtitle: Text(time.toLocal().toIso8601String()),
    );
  }
}
