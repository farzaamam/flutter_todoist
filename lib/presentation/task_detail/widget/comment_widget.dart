import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentWidget extends ConsumerWidget {
  final String taskId;

  const CommentWidget({super.key, required this.taskId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Replace these with your actual provider values

    return Column(
      children: [
        // Add Comment Input
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Add a comment...",
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  // TODO: Add comment logic
                },
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                // TODO: Submit comment
              },
              child: const Text("Send"),
            ),
          ],
        ),
      ],
    );
  }
}
