import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobboard/providers/user_provider.dart';
import 'package:jobboard/utils/colors.dart';
import 'package:jobboard/utils/constants.dart';
import 'package:jobboard/utils/routes_handler.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
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
      title: Constants.appName,
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
      onGenerateRoute: generateRoute,
    );
  }
}
