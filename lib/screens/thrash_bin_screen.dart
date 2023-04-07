import 'package:flutter/material.dart';
import 'package:todoonline/blocs/blocs.dart';
import 'package:todoonline/widgets/drawer.dart';
import 'package:todoonline/widgets/widgets.dart';

class ThrashBinScreen extends StatelessWidget {
  static const routeName = "/bin";
  const ThrashBinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recycle Bin"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text("${state.removedTasks.length} Tasks"),
                ),
              ),
              TasksList(
                tasksList: state.removedTasks,
              ),
            ],
          );
        },
      ),
    );
  }
}
