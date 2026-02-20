import 'package:flutter/material.dart';

void main() {
  runApp(const MyAlarmClockApp());
}

class MyAlarmClockApp extends StatelessWidget {
  const MyAlarmClockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'the_alarm_clock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'SF Pro Display',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
        colorScheme: ColorScheme.dark(
          primary: Colors.blue[400]!,
          surface: Colors.grey[900]!,
        ),
        useMaterial3: true,
      ),
      home: const AlarmHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AlarmHomePage extends StatefulWidget {
  const AlarmHomePage({super.key});

  @override
  State<AlarmHomePage> createState() => _AlarmHomePageState();
}

class _AlarmHomePageState extends State<AlarmHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const AlarmsPage(),
    const ClockPage(),
    const WorldClockPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'the_alarm_clock',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Timer',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey[600],
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: 'Alarm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Clock',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'World',
          ),
        ],
      ),
    );
  }
}

class AlarmsPage extends StatefulWidget {
  const AlarmsPage({super.key});

  @override
  State<AlarmsPage> createState() => _AlarmsPageState();
}

class _AlarmsPageState extends State<AlarmsPage> {
  bool _is24HourFormat = false;
  String _selectedPeriod = 'AM';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Active alarm
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '9:41',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Mon 20th • Bogota, Colombia',
                      style: TextStyle(color: Colors.grey[400], fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Alarm in 1 hour',
                        style: TextStyle(color: Colors.blue, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                Switch(
                  value: true,
                  onChanged: (value) {},
                  activeThumbColor: Colors.blue,
                ),
              ],
            ),
          ),

          // New alarm section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '-New Alarm-',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Time picker
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                // Time display
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '06',
                      style: TextStyle(fontSize: 72, fontWeight: FontWeight.w300),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: const Text(
                        ':',
                        style: TextStyle(fontSize: 72, color: Colors.grey),
                      ),
                    ),
                    const Text(
                      '45',
                      style: TextStyle(fontSize: 72, fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => _selectedPeriod = 'AM'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: _selectedPeriod == 'AM'
                                  ? Colors.blue
                                  : Colors.grey[800],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'AM',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => setState(() => _selectedPeriod = 'PM'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: _selectedPeriod == 'PM'
                                  ? Colors.blue
                                  : Colors.grey[800],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'PM',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Time picker sliders
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Text('Hour', style: TextStyle(color: Colors.grey)),
                          Slider(
                            value: 6,
                            min: 1,
                            max: 12,
                            divisions: 11,
                            onChanged: (value) {},
                            activeColor: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text('Min', style: TextStyle(color: Colors.grey)),
                          Slider(
                            value: 45,
                            min: 0,
                            max: 59,
                            divisions: 59,
                            onChanged: (value) {},
                            activeColor: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Format toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChoiceChip(
                      label: const Text('24H'),
                      selected: !_is24HourFormat,
                      onSelected: (selected) =>
                          setState(() => _is24HourFormat = !selected),
                      backgroundColor: Colors.grey[800],
                      selectedColor: Colors.blue,
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('12H'),
                      selected: _is24HourFormat,
                      onSelected: (selected) =>
                          setState(() => _is24HourFormat = selected),
                      backgroundColor: Colors.grey[800],
                      selectedColor: Colors.blue,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Alarm settings
          _buildSettingItem('Set Alarm name', 'Wake up'),
          _buildSettingItem('Repeat', 'Mo Tu We Th Fr Sa Su'),
          _buildSettingItem('Snooze Duration', '5 min'),
          _buildSettingItem('Sound', 'Constellation'),
          _buildSettingItem('Auto silent time', '15 min'),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[800]!, width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
          Row(
            children: [
              Text(value, style: TextStyle(color: Colors.grey[400], fontSize: 16)),
              const SizedBox(width: 8),
              Icon(Icons.chevron_right, color: Colors.grey[600]),
            ],
          ),
        ],
      ),
    );
  }
}

class ClockPage extends StatelessWidget {
  const ClockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Text(
                  'CLOCK',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  '12:20',
                  style: TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'WED SEPTEMBER 7',
                  style: TextStyle(color: Colors.grey[400], fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  'SHANGHAI',
                  style: TextStyle(color: Colors.grey[500], fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                _buildTimeZone('09:05', 'WED SEPTEMBER 7', 'PARIS'),
                _buildTimeZone('09:00', 'WED SEPTEMBER 7', 'PARIS'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeZone(String time, String date, String location) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
            ],
          ),
          Text(
            location,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}

class WorldClockPage extends StatelessWidget {
  const WorldClockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Add New Time',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Icon(Icons.add_circle_outline, color: Colors.blue[400]),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              _buildWorldClockItem('Benin Nigeria', '7:00 AM'),
              _buildWorldClockItem('USA', '5:30 AM'),
              _buildWorldClockItem('Croatia • Zagreb', '5:00 AM'),
              _buildWorldClockItem('Bahrain • Manama', '7:00 AM'),
              _buildWorldClockItem('Belgium • Brussels', '1:00 PM'),
              _buildWorldClockItem('Burundi • Bujumbura', '7:00 AM'),
              _buildWorldClockItem('Cameroon • Yaounde', '7:00 AM'),
              _buildWorldClockItem('Cape Verde • Prairie', '7:00 AM'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWorldClockItem(String location, String time) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[800]!),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(location, style: const TextStyle(fontSize: 16)),
          Text(
            time,
            style: TextStyle(
              color: Colors.blue[400],
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
