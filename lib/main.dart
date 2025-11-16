import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:imc_calculator/core/app_colors.dart';
import 'package:imc_calculator/screens/imc_home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          surface: AppColors.backgrounds,
          secondary: AppColors.secondary,
        ),
        scaffoldBackgroundColor: AppColors.backgrounds,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.backgrounds,
          foregroundColor: AppColors.white,
          centerTitle: false,
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: AppColors.white),
        ),
      ),
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        final TextScaler scaler = TextScaler.linear(
          mediaQuery.textScaler.scale(1).clamp(1.0, 1.2),
        );

        return ScrollConfiguration(
          behavior: const _AppScrollBehavior(),
          child: MediaQuery(
            data: mediaQuery.copyWith(textScaler: scaler),
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
      home: const ImcHomeScreen(),
    );
  }
}

class _AppScrollBehavior extends ScrollBehavior {
  const _AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
    PointerDeviceKind.unknown,
  };

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
