import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoist/presentation/create_task/create_task_controller.dart';

class CreateTaskPage extends ConsumerWidget {
  const CreateTaskPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(createTaskControllerProvider.notifier);
    final state = ref.watch(createTaskControllerProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('Create Task')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTitleField(controller),
              const SizedBox(height: 16),
              _buildDescriptionField(controller),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed:
              state.isSubmitting
                  ? null
                  : () async {
                    _submit(context, controller);
                  },
          child:
              state.isSubmitting
                  ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                  : const Text('Save Task'),
        ),
      ),
    );
  }

  Widget _buildDescriptionField(CreateTaskController controller) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Description',
        border: OutlineInputBorder(),
      ),
      maxLines: 5,
      onChanged: controller.setDescription,
    );
  }

  _submit(BuildContext context, CreateTaskController controller) async {
    final submitted = await controller.submit();
    if (!context.mounted) return;
    if (submitted) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Something went wrong')));
    }
  }

  Widget _buildTitleField(CreateTaskController controller) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Title',
        border: OutlineInputBorder(),
      ),
      onChanged: controller.setTitle,
      maxLines: 1,
      validator:
          (value) =>
              (value == null || value.trim().isEmpty)
                  ? 'Title is required'
                  : null,
    );
  }
}
