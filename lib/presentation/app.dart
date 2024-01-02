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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white).copyWith(
          primary: const Color(0xFF2669FE),
          secondary: const Color(0xFF2669FE),
          tertiary: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}
