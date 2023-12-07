import 'package:flutter/material.dart';
import '../app/routes/router.dart';
import '../app/theme/theme.dart';

class MyDigitalId extends StatelessWidget {
  const MyDigitalId({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Digital Id',
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
      theme: AppTheme.light,
      themeMode: ThemeMode.system,
    );
  }
}
