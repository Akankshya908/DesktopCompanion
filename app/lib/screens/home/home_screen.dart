import 'package:app/widgets/action_button.dart';
import 'package:app/widgets/companion_card.dart';
import 'package:app/widgets/info_tile.dart';
import 'package:app/widgets/water_progress_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _glassesDrunk = 0;
  final int _goal = 8;

  void _drinkWater() {
    setState(() {
      _glassesDrunk = (_glassesDrunk + 1).clamp(0, _goal);
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_glassesDrunk / _goal).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Desktop Companion"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const CompanionCard(
  name: 'Aqua',
  mood: 'Time to drink some water!',
  placeholderChild: Image(
    image: AssetImage('assets/sprites/companion.png'),
    fit: BoxFit.contain,
  ),
),
              const SizedBox(height: 20),
              WaterProgressCard(
                currentGlasses: _glassesDrunk,
                goalGlasses: _goal,
                progress: progress,
              ),
              const SizedBox(height: 20),
              ActionButton(
                label: 'Drink Water',
                icon: Icons.water_drop_outlined,
                onPressed: _drinkWater,
                isPrimary: true,
              ),
              const SizedBox(height: 24),
              Text(
                'Today at a glance',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              const InfoTile(
                icon: Icons.flag_outlined,
                title: "Today's Goal",
                subtitle: '8 glasses',
              ),
              const SizedBox(height: 12),
              const InfoTile(
                icon: Icons.schedule_outlined,
                title: 'Reminder',
                subtitle: 'Every 45 minutes',
              ),
            ],
          ),
        ),
      ),
    );
  }
}