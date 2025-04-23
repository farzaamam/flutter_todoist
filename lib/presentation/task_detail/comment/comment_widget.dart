import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoist/presentation/task_detail/comment/comment_controller.dart';
import 'package:todoist/domain/model/comment.dart';

class CommentWidget extends ConsumerStatefulWidget {
  final String taskId;

  const CommentWidget({super.key, required this.taskId});

  @override
  ConsumerState<CommentWidget> createState() => _CommentWidget();
}

class _CommentWidget extends ConsumerState<CommentWidget> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit(CommentController controller) async {
    final content = _textController.text.trim();
    if (content.isEmpty) return;
    await controller.createComment(content);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(commentControllerProvider(widget.taskId));
    final controller = ref.read(
      commentControllerProvider(widget.taskId).notifier,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Comments', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        _buildCommentList(state.comments),
        const SizedBox(height: 16),
        _buildCommentInput(controller, state.isCreatingComment),
      ],
    );
  }

  Widget _buildCommentList(AsyncValue<List<Comment>> comments) {
    return comments.when(
      data:
          (items) =>
              items.isEmpty
                  ? const Text('No comments yet.')
                  : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Text(
                            items[index].content,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      );
                    },
                  ),
      loading: () => const Center(child: LinearProgressIndicator()),
      error: (_, _) => Text('Failed to load comments'),
    );
  }

  Widget _buildCommentInput(CommentController controller, bool isCreating) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Write a comment...',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: isCreating ? null : () => _handleSubmit(controller),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child:
              isCreating
                  ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                  : const Text('Send'),
        ),
      ],
    );
  }
}
