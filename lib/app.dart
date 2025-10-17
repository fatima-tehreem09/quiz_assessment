import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/core/di/locator.dart';
import 'src/core/router/app_router.dart';
import 'src/core/theme/theme_cubit.dart';

class App extends StatefulWidget {
  const App({super.key});

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await setupServiceLocator();
    runApp(App());
  }

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    serviceLocator<ThemeCubit>().initializeTheme();
  }

  @override
  Widget build(BuildContext context) {
    final router = createRouter();
    return BlocProvider<ThemeCubit>(
      create: (context) => serviceLocator<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Quiz',
            theme: ThemeCubit.lightTheme,
            darkTheme: ThemeCubit.darkTheme,
            themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
