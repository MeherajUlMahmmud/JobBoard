import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/user_data_provider.dart';
import 'providers/user_profile_provider.dart';
import 'screens/utility_screens/SplashScreen.dart';
import 'utils/constants.dart';
import 'utils/routes_handler.dart';
import 'utils/theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => UserProfileProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: createTheme(),
      onGenerateRoute: generateRoute,
      home: const SplashScreen(),
    );
  }
}
