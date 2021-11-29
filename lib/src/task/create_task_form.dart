import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_helper/src/models/form_status.dart';

import 'cubit/create_task_cubit.dart';

class CreateTaskForm extends StatelessWidget {
  const CreateTaskForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: BlocConsumer<CreateTaskCubit, CreateTaskState>(
              listener: (context, state) {
                if (state.status == FormStatus.success) Navigator.pop(context);
              },
              builder: (context, state) {
                void submit() {
                  if (state.title.isEmpty) return;

                  context.read<CreateTaskCubit>().submit();
                }

                return ListView(
                  shrinkWrap: true,
                  children: [
                    Text(
                      'New Task',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      initialValue: state.title,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                      onChanged: (value) => context
                          .read<CreateTaskCubit>()
                          .setTitle(value.trim()),
                      onFieldSubmitted: (_) => submit(),
                    ),
                    const SizedBox(height: 10),
                    if (state.status == FormStatus.inProgress)
                      const Center(child: CircularProgressIndicator())
                    else
                      ElevatedButton(
                        onPressed: () => submit(),
                        child: const Text('Create'),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      );
}
