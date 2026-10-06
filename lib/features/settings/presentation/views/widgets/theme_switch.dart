import 'package:bookly_app/features/settings/presentation/manager/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state == ThemeMode.dark;

    return Switch(
      value: isDarkMode,
      onChanged: (value) {
        context.read<ThemeCubit>().changeTheme(
          value ? ThemeMode.dark : ThemeMode.light,
        );
      },
    );
  }
}
