import 'package:flutter/material.dart';

import 'src/core/routes/route_generator.dart';
import 'src/presentation/pages/home_screen.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee App',
      initialRoute: HomeScreen.route,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
