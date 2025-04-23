import 'package:flutter/material.dart';
import 'package:todoist/domain/model/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  final bool isPortrait;
  final bool draggable;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
    required this.isPortrait,
    required this.draggable,
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

    return ConstrainedBox(
      constraints: cardConstraints,
      child:
          draggable
              ? LongPressDraggable<Task>(
                data: task,
                feedback: _buildCardContent(),
                childWhenDragging: Opacity(
                  opacity: 0.4,
                  child: _buildCardContent(),
                ),
                child: InkWell(onTap: onTap, child: _buildCardContent()),
              )
              : InkWell(onTap: onTap, child: _buildCardContent()),
    );
  }

  Widget _buildCardContent() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side:
            draggable
                ? BorderSide.none
                : BorderSide(color: Colors.grey.shade400, width: 1),
      ),
      color: draggable ? Colors.white : Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                task.content,
                maxLines: isPortrait ? 4 : 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: draggable ? Colors.black : Colors.grey,
                  fontStyle: draggable ? FontStyle.normal : FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
