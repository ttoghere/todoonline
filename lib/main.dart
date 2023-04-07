import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todoonline/blocs/blocs.dart';
import 'package:todoonline/blocs/switch/switch_bloc.dart';
import 'package:todoonline/screens/screens_shelf.dart';
import 'package:todoonline/screens/thrash_bin_screen.dart';
import 'package:todoonline/services/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  HydratedBlocOverrides.runZoned(
    () => runApp(const MyApp()),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TasksBloc()),
        BlocProvider(create: (_) => SwitchBloc())
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: state.switchValue
                ? AppThemes.appThemeData[AppTheme.lightTheme]
                : AppThemes.appThemeData[AppTheme.darkTheme],
            initialRoute: TasksScreen.routeName,
            routes: {
              TasksScreen.routeName: (context) => const TasksScreen(),
              ThrashBinScreen.routeName: (context) => const ThrashBinScreen(),
            },
          );
        },
      ),
    );
  }
}
