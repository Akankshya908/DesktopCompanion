import 'package:flutter/material.dart';
import '../models/water_model.dart';
import '../core/services/storage_service.dart';

class WaterProvider extends ChangeNotifier {
  final WaterModel _water = WaterModel(
    currentGlasses: 0,
    goalGlasses: 8,
  );

  WaterModel get water => _water;

  WaterProvider() {
    loadData();
  }

  Future<void> loadData() async {
    _water.currentGlasses = await StorageService.loadWaterCount();
    notifyListeners();
  }

  Future<void> drinkWater() async {
    if (_water.currentGlasses < _water.goalGlasses) {
      _water.currentGlasses++;
      await StorageService.saveWaterCount(_water.currentGlasses);
      notifyListeners();
    }
  }

  Future<void> reset() async {
    _water.currentGlasses = 0;
    await StorageService.resetWaterCount();
    notifyListeners();
  }
}