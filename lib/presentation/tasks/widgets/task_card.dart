import 'package:flutter/material.dart';
import 'package:todoist/domain/model/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  final bool isPortrait;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
    required this.isPortrait,
  });

  @override
  Widget build(BuildContext context) {
    final cardConstraints =
        isPortrait
            ? const BoxConstraints(
              maxHeight: double.infinity,
              maxWidth: 128,
              minWidth: 128,
            )
            : const BoxConstraints(maxWidth: double.infinity, maxHeight: 80);

    Widget buildCardContent() => Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            task.content,
            maxLines: isPortrait ? 4 : 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
    return ConstrainedBox(
      constraints: cardConstraints,
      child: LongPressDraggable<Task>(
        data: task,
        feedback: buildCardContent(),
        childWhenDragging: Opacity(opacity: 0.4, child: buildCardContent()),
        child: InkWell(onTap: onTap, child: buildCardContent()),
      ),
    );
  }
}
