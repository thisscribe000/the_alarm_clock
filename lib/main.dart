import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/alarm_screen.dart';
import 'screens/world_clock_screen.dart';
import 'screens/stopwatch_screen.dart';
import 'screens/timer_screen.dart';

void main() => runApp(TheAlarmClockApp());

class TheAlarmClockApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Alarm Clock',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
      routes: {
        '/alarm': (_) => AlarmScreen(),
        '/world': (_) => WorldClockScreen(),
        '/stopwatch': (_) => StopwatchScreen(),
        '/timer': (_) => TimerScreen(),
      },
    );
  }
}
