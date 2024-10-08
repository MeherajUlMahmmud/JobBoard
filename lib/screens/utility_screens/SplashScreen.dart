import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../providers/user_data_provider.dart';
import '../../utils/constants.dart';
import '../../utils/local_storage.dart';
import '../auth_screens/login_screen.dart';
import '../main_screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = Constants.splashScreenRouteName;

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LocalStorage localStorage = LocalStorage();

  void checkUser() async {
    final Map<String, dynamic> tokens = await localStorage.readData('tokens');

    if (!mounted) return;
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (tokens['access'] == null || tokens['refresh'] == null) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      });
    } else {
      // Set tokens in the provider
      userProvider.setTokens(tokens);

      // Load user data from local storage
      final userDataJson = await localStorage.readData('user');

      UserBase userData = UserBase.fromJson(userDataJson);
      // Set user data in the provider
      userProvider.setUserData(userData);

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, MainScreen.routeName);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          Constants.appName,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
