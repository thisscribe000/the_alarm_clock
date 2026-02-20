import 'package:flutter/material.dart';
import '../models/timezone.dart';
import '../services/timezone_service.dart';

class TimeZoneProvider extends ChangeNotifier {
  final TimeZoneService _timeZoneService = TimeZoneService();
  
  List<TimeZoneItem> _timeZones = [];
  bool _isLoading = true;
  String? _error;

  List<TimeZoneItem> get timeZones => _timeZones;
  bool get isLoading => _isLoading;
  String? get error => _error;

  TimeZoneProvider() {
    loadTimeZones();
  }

  Future<void> loadTimeZones() async {
    try {
      _isLoading = true;
      _error = null;
      _timeZones = await _timeZoneService.getAllTimeZones();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTimeZone({
    required String location,
    required String timeZoneName,
    required String displayName,
    String? country,
    int utcOffset = 0,
  }) async {
    try {
      await _timeZoneService.addTimeZone(
        location: location,
        timeZoneName: timeZoneName,
        displayName: displayName,
        country: country,
        utcOffset: utcOffset,
      );
      await loadTimeZones();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateTimeZone(TimeZoneItem timeZone) async {
    try {
      await _timeZoneService.updateTimeZone(timeZone);
      await loadTimeZones();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteTimeZone(String id) async {
    try {
      await _timeZoneService.deleteTimeZone(id);
      await loadTimeZones();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<TimeZoneItem?> getTimeZoneById(String id) async {
    try {
      return await _timeZoneService.getTimeZoneById(id);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }
}
