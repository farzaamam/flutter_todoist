import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoist/di/global_providers.dart';
import 'package:todoist/domain/usecase/time_tracking_use_case.dart';

final timerControllerProvider = StateNotifierProvider.autoDispose
    .family<TimerController, TimerState, String>((ref, taskId) {
      final useCase = ref.read(
        timeTrackingUseCaseProvider,
      ); // your use case provider
      return TimerController(useCase: useCase, taskId: taskId);
    });

class TimerController extends StateNotifier<TimerState> {
  final String taskId;
  final TimeTrackingUseCase useCase;

  Timer? _ticker;

  TimerController({required this.taskId, required this.useCase})
    : super(TimerState(isRunning: false, duration: 0)) {
    _initialize();
  }

  Future<void> _initialize() async {
    final duration = await useCase.getTotalTrackedTime(taskId);
    final isRunning = await useCase.isRunning(taskId);
    state = TimerState(duration: duration, isRunning: isRunning);

    if (isRunning) {
      _startTicker();
    }
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) async {
      final updatedDuration = await useCase.getTotalTrackedTime(taskId);
      state = state.copyWith(duration: updatedDuration);
    });
  }

  Future<void> toggle() async {
    if (state.isRunning) {
      _ticker?.cancel();
      final totalBeforeStop = await useCase.getTotalTrackedTime(taskId);
      await useCase.stop(taskId);
      state = state.copyWith(duration: totalBeforeStop, isRunning: false);
    } else {
      await useCase.start(taskId);
      _startTicker();
      final updatedDuration = await useCase.getTotalTrackedTime(taskId);
      state = state.copyWith(duration: updatedDuration, isRunning: true);
    }
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }
}

class TimerState {
  final bool isRunning;
  final int duration;

  TimerState({required this.isRunning, required this.duration});

  TimerState copyWith({bool? isRunning, int? duration}) {
    return TimerState(
      isRunning: isRunning ?? this.isRunning,
      duration: duration ?? this.duration,
    );
  }
}
