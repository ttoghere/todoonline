import 'package:flutter/material.dart';
import 'package:todoonline/blocs/blocs.dart';
import 'package:todoonline/models/models.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    super.key,
    required this.tasksList,
  });

  final List<Task> tasksList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: tasksList.length,
        itemBuilder: (context, index) {
          return BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              Task task = tasksList[index];
              return TaskTile(task: task);
            },
          );
        });
  }
}

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.title,
        style: TextStyle(
            decoration: task.isDone! ? TextDecoration.lineThrough : null),
      ),
      leading: !task.isDeleted!
          ? Checkbox(
              value: task.isDone,
              onChanged: (value) {
                context.read<TasksBloc>().add(UpdateTask(task: task));
              },
            )
          : null,
      trailing: IconButton(
        onPressed: () {
          _removeOrDeleteTask(context, task);
        },
        icon: const Icon(
          Icons.delete_forever,
        ),
      ),
    );
  }

  _removeOrDeleteTask(BuildContext context, Task task) {
    task.isDeleted!
        ? context.read<TasksBloc>().add(DeleteTask(task: task))
        : context.read<TasksBloc>().add(RemoveTask(task: task));
  }
}
