import 'package:jobboard/providers/user_provider.dart';
import 'package:jobboard/screens/auth_screens/LoginScreen.dart';
import 'package:jobboard/screens/home_screen.dart';
import 'package:jobboard/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LocalStorage localStorage = LocalStorage();

  void checkUser() async {
    final Map<String, dynamic> tokens = await localStorage.readData('tokens');
    final Map<String, dynamic> user = await localStorage.readData('user');
    if (tokens['access'] == null || tokens['refresh'] == null) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      });
    } else {
      Provider.of<UserProvider>(context, listen: false).setUser(user);
      Provider.of<UserProvider>(context, listen: false).setTokens(tokens);
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
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
          "JobBoard",
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
