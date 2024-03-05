import 'package:flutter/material.dart';
import 'package:jobboard/screens/auth_screens/ForgotPasswordScreen.dart';
import 'package:jobboard/screens/auth_screens/LoginScreen.dart';
import 'package:jobboard/screens/auth_screens/OTPScreen.dart';
import 'package:jobboard/screens/auth_screens/SignUpScreen.dart';
import 'package:jobboard/screens/home_screen.dart';
import 'package:jobboard/screens/main_screens/MainScreen.dart';
import 'package:jobboard/screens/profile_screens/ProfileScreen.dart';
import 'package:jobboard/screens/profile_screens/UpdateProfileScreen.dart';
import 'package:jobboard/screens/utility_screens/AccountSettingsScreen.dart';
import 'package:jobboard/screens/utility_screens/NotFoundScreen.dart';
import 'package:jobboard/screens/utility_screens/SettingsScreen.dart';
import 'package:jobboard/screens/utility_screens/SplashScreen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SplashScreen());
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case SignUpScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SignUpScreen());
    case ForgotPasswordScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen());
    case OTPScreen.routeName:
      return MaterialPageRoute(builder: (context) => const OTPScreen());
    case MainScreen.routeName:
      return MaterialPageRoute(builder: (context) => const MainScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (context) => HomeScreen());
    case ProfileScreen.routeName:
      return MaterialPageRoute(builder: (context) => const ProfileScreen());
    case UpdateProfileScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const UpdateProfileScreen());
    case SettingsScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SettingsScreen());
    case AccountSettingsScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const AccountSettingsScreen());
    default:
      return MaterialPageRoute(builder: (context) => const NotFoundScreen());
  }
}
