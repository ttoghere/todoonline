import 'package:flutter/material.dart';
import 'package:todoonline/blocs/blocs.dart';
import 'package:todoonline/screens/tasks_screen.dart';
import 'package:todoonline/screens/thrash_bin_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.red[900],
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  Text(
                    "Task Drawer",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.red[900],
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                children: [
                  BlocProvider(
                    create: (context) => TasksBloc(),
                    child: ListTile(
                      title: Text(
                        "Tasks List",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(TasksScreen.routeName);
                      },
                      leading: const Icon(
                        Icons.list,
                        color: Colors.black,
                      ),
                      trailing: Text(
                        context
                            .watch<TasksBloc>()
                            .state
                            .allTasks
                            .length
                            .toString(),
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 3,
                  ),
                  BlocBuilder<TasksBloc, TasksState>(
                    builder: (context, state) {
                      return ListTile(
                        title: Text(
                          "Thrash Bin",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        leading: const Icon(
                          Icons.delete_forever,
                          color: Colors.black,
                        ),
                        onTap: () => Navigator.of(context)
                            .pushNamed(ThrashBinScreen.routeName),
                        trailing: Text(
                          "${state.removedTasks.length}",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      );
                    },
                  ),
                  const Divider(
                    thickness: 3,
                  ),
                  BlocBuilder<SwitchBloc, SwitchState>(
                    builder: (context, state) {
                      bool switchV = state.switchValue;
                      return Switch(
                        value: switchV,
                        onChanged: (value) {
                          value
                              ? context.read<SwitchBloc>().add(SwitchOn())
                              : context.read<SwitchBloc>().add(SwitchOff());
                        },
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
