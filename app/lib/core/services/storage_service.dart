import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String waterKey = "water_count";

  static Future<void> saveWaterCount(int count) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(waterKey, count);
  }

  static Future<int> loadWaterCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(waterKey) ?? 0;
  }

  static Future<void> resetWaterCount() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(waterKey);
  }
}