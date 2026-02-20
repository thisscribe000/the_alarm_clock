class Alarm {
  final String id;
  final DateTime time;
  final String label;
  final bool enabled;

  Alarm({required this.id, required this.time, this.label = '', this.enabled = true});
}
