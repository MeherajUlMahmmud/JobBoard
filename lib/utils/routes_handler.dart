import 'package:flutter/material.dart';
import 'package:jobboard/screens/auth_screens/forgot_password_screen.dart';
import 'package:jobboard/screens/auth_screens/login_screen.dart';
import 'package:jobboard/screens/auth_screens/otp_screen.dart';
import 'package:jobboard/screens/auth_screens/sign_up_screen.dart';
import 'package:jobboard/screens/home_screen.dart';
import 'package:jobboard/screens/main_screens/main_screen.dart';
import 'package:jobboard/screens/profile_screens/profile_screen.dart';
import 'package:jobboard/screens/profile_screens/update_profile_screen.dart';
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
