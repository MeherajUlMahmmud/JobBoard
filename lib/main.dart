import 'package:flutter/material.dart';
import 'package:jobboard/providers/user_provider.dart';
import 'package:jobboard/screens/auth_screens/ForgotPasswordScreen.dart';
import 'package:jobboard/screens/auth_screens/LoginScreen.dart';
import 'package:jobboard/screens/auth_screens/OTPScreen.dart';
import 'package:jobboard/screens/auth_screens/SignUpScreen.dart';
import 'package:jobboard/screens/home_screen.dart';
import 'package:jobboard/screens/main_screens/SearchScreen.dart';
import 'package:jobboard/screens/profile_screens/ProfileScreen.dart';
import 'package:jobboard/screens/profile_screens/UpdateProfileScreen.dart';
import 'package:jobboard/screens/utility_screens/AccountSettingsScreen.dart';
import 'package:jobboard/screens/utility_screens/SettingsScreen.dart';
import 'package:jobboard/utils/colors.dart';
import 'package:provider/provider.dart';

import 'screens/utility_screens/SplashScreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JobBoard',
      theme: ThemeData(
        primarySwatch: createMaterialColor(const Color(0xB316BFC4)),
        primaryColor: createMaterialColor(const Color(0xB316BFC4)),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
        inputDecorationTheme: InputDecorationTheme(
          prefixIconColor: Colors.grey,
          suffixIconColor: createMaterialColor(const Color(0xFF100720)),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: createMaterialColor(const Color(0xFF100720)),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: createMaterialColor(const Color(0xFF100720)),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          labelStyle: TextStyle(
            color: createMaterialColor(const Color(0xFF100720)),
          ),
          hintStyle: TextStyle(
            color: createMaterialColor(const Color(0xFF100720)),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: createMaterialColor(const Color(0xFF100720)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: createMaterialColor(const Color(0xFF100720)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        ForgotPasswordScreen.routeName: (context) =>
            const ForgotPasswordScreen(),
        OTPScreen.routeName: (context) => const OTPScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        SearchScreen.routeName: (context) => const SearchScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
        UpdateProfileScreen.routeName: (context) => const UpdateProfileScreen(),
        SettingsScreen.routeName: (context) => const SettingsScreen(),
        AccountSettingsScreen.routeName: (context) =>
            const AccountSettingsScreen(),
      },
    );
  }
}
