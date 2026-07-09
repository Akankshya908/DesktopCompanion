import 'package:app/widgets/action_button.dart';
import 'package:app/widgets/companion_card.dart';
import 'package:app/widgets/floating_companion.dart';
import 'package:app/widgets/info_tile.dart';
import 'package:app/widgets/reminder_popup.dart';
import 'package:app/widgets/water_progress_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/services/sprite_loader.dart';
import '../../providers/companion_provider.dart';
import '../../providers/reminder_provider.dart';
import '../../providers/water_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _reminderDialogVisible = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final reminder = context.read<ReminderProvider>();
      final companion = context.read<CompanionProvider>();

      reminder.setReminderCallback(() {
        if (!mounted || _reminderDialogVisible) {
          return;
        }

        reminder.stop();
        _reminderDialogVisible = true;
        companion.showReminderDialogue();

        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (dialogContext) {
            return ReminderPopup(
              onYes: () async {
                final waterProvider = dialogContext.read<WaterProvider>();
                final companion = dialogContext.read<CompanionProvider>();

                await waterProvider.drinkWater();
                if (!mounted) {
                  return;
                }

                if (waterProvider.water.currentGlasses >= waterProvider.water.goalGlasses) {
                  companion.showCelebration();
                } else {
                  companion.showDrinkReminder();
                }

                _reminderDialogVisible = false;
                reminder.restart();
              },
              onSnooze: () async {
                if (!mounted) {
                  return;
                }

                _reminderDialogVisible = false;
                reminder.snoozeFor(const Duration(minutes: 10));
              },
            );
          },
        ).then((_) {
          if (mounted) {
            _reminderDialogVisible = false;
          }
        });
      });

      reminder.start();
    });
  }

  @override
  Widget build(BuildContext context) {
    final waterProvider = context.watch<WaterProvider>();
    final water = waterProvider.water;
    final companion = context.watch<CompanionProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Desktop Companion'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CompanionCard(
                    name: 'Aqua',
                    mood: 'Time to drink some water!',
                    placeholderChild: Image(
                      image: AssetImage(SpriteLoader.defaultSpritePath()),
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),
                  WaterProgressCard(
                    currentGlasses: water.currentGlasses,
                    goalGlasses: water.goalGlasses,
                    progress: water.progress,
                  ),
                  const SizedBox(height: 20),
                  ActionButton(
                    label: 'Drink Water',
                    icon: Icons.water_drop_outlined,
                    onPressed: () async {
                      final companion = context.read<CompanionProvider>();
                      await waterProvider.drinkWater();
                      if (!mounted) return;
                      if (waterProvider.water.currentGlasses >= waterProvider.water.goalGlasses) {
                        companion.showCelebration();
                      } else {
                        companion.showDrinkReminder();
                      }
                    },
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
                  InfoTile(
                    icon: Icons.flag_outlined,
                    title: "Today's Goal",
                    subtitle: '${water.goalGlasses} glasses',
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
            FloatingCompanion(
              visible: companion.visible,
              message: companion.message,
              currentState: companion.currentState,
            ),
          ],
        ),
      ),
    );
  }
}