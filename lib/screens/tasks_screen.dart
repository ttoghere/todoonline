import 'package:flutter/material.dart';
import 'package:todoonline/blocs/blocs.dart';
import 'package:todoonline/models/task.dart';
import 'package:todoonline/services/guild_gen.dart';
import 'package:todoonline/widgets/drawer.dart';
import 'package:todoonline/widgets/widgets.dart';

class TasksScreen extends StatelessWidget {
  static const routeName = "/tasks";
  const TasksScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksList = state.allTasks;
        return SafeArea(
          child: Scaffold(
            drawer: MainDrawer(),
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "Tasks App",
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    _addTask(context);
                  },
                  icon: const Icon(
                    Icons.add,
                  ),
                ),
              ],
            ),
            body: TasksBody(tasksList: tasksList),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _addTask(context);
              },
              child: const Icon(
                Icons.add,
              ),
            ),
          ),
        );
      },
    );
  }

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddTaskWidget(),
        ),
      ),
    );
  }
}

class TasksBody extends StatelessWidget {
  const TasksBody({
    super.key,
    required this.tasksList,
  });

  final List<Task> tasksList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Chip(label: Text("Tasks:${tasksList.length}")),
        ),
        const SizedBox(
          height: 10,
        ),
        TasksList(tasksList: tasksList)
      ],
    );
  }
}

// ignore: must_be_immutable
class AddTaskWidget extends StatelessWidget {
  TextEditingController titleController = TextEditingController();

  AddTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _taskTitle(),
          const SizedBox(
            height: 10,
          ),
          _actionButtons(context)
        ],
      ),
    );
  }

  Column _taskTitle() {
    return Column(
      children: [
        const Text("Add Task"),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: titleController,
          autofocus: true,
          decoration: const InputDecoration(
            label: Text("Title"),
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Row _actionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.delete,
          ),
        ),
        BlocProvider(
          create: (context) => TasksBloc(),
          child: IconButton(
            onPressed: () async {
              context.read<TasksBloc>().add(
                    AddTask(
                      task: Task(
                        id: GUIDGen.generate(),
                        title: titleController.text,
                      ),
                    ),
                  );
              titleController.clear();
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ),
      ],
    );
  }
}
