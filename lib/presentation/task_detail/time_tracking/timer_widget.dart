import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoist/presentation/task_detail/time_tracking/task_timer_controller.dart';

class TimerWidget extends ConsumerWidget {
  final String taskId;

  const TimerWidget({super.key, required this.taskId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(timerControllerProvider(taskId));

    String formatDuration(int totalSeconds) {
      final d = Duration(seconds: totalSeconds);
      return d.toString().split('.').first.padLeft(8, "0");
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Time Spent on Task",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Text(
          formatDuration(timerState.duration),
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            fontFamily: 'RobotoMono',
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            ref.read(timerControllerProvider(taskId).notifier).toggle();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: timerState.isRunning ? Colors.redAccent : Colors.green,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              timerState.isRunning ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
      ],
    );
  }
}