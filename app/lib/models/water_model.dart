class WaterModel {
  int currentGlasses;
  int goalGlasses;

  WaterModel({
    required this.currentGlasses,
    required this.goalGlasses,
  });

  double get progress =>
      goalGlasses == 0 ? 0 : currentGlasses / goalGlasses;

  int get remaining =>
      goalGlasses - currentGlasses;

  bool get completed =>
      currentGlasses >= goalGlasses;
}