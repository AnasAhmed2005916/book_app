import 'package:bookly_app/core/theme/app_theme.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/service_locator.dart';
import 'package:bookly_app/features/home/data/repos/home_repo_impl.dart';
import 'package:bookly_app/features/home/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly_app/features/home/presentation/manager/newest_books_cubit/newset_books_cubit.dart';
import 'package:bookly_app/features/settings/presentation/manager/theme_cubit/theme_cubit.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();

  final preferences = await SharedPreferences.getInstance();

  runApp(
    BlocProvider(
      create: (context) => ThemeCubit(preferences),
      child: const BooklyApp(),
    ),
  );
}

class BooklyApp extends StatelessWidget {
  const BooklyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  FeaturedBooksCubit(getIt.get<HomeRepoImpl>())
                    ..fetchFeaturedBooks(),
            ),
            BlocProvider(
              create: (context) =>
                  NewestBooksCubit(getIt.get<HomeRepoImpl>())
                    ..fetchNewsetBooks(),
            ),
          ],
          child: MaterialApp.router(
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
          ),
        );
      },
    );
  }
}

// هبدأ فى الفيديو 84
/**
 * https://www.googleapis.com/books/v1/volumes?q=programming
 * 
 * https://chatgpt.com/share/6abdb3d5-7bf8-83ea-91de-a95be69d7138
 */
