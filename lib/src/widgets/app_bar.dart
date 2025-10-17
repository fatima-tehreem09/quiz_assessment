import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import '../core/di/locator.dart';
import '../core/theme/theme_cubit.dart';
import '../core/constants/colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    required this.title,
    this.showThemeToggle = true,
    this.actions,
  });

  final String title;
  final bool showThemeToggle;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      bloc: serviceLocator<ThemeCubit>(),
      builder: (context, state) {
        return AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: FadeInDown(
            duration: const Duration(milliseconds: 600),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          actions: [
            if (showThemeToggle) ...[
              FadeInRight(
                duration: const Duration(milliseconds: 800),
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    onPressed: () {
                      serviceLocator<ThemeCubit>().toggleTheme();
                    },
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        state.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                        key: ValueKey(state.isDarkMode),
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    tooltip: state.isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
                  ),
                ),
              ),
            ],
            if (actions != null) ...actions!,
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: state.isDarkMode 
                  ? AppColors.darkGradient 
                  : AppColors.primaryGradient,
                stops: const [0.0, 1.0],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 70);
}
