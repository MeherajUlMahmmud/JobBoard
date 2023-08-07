import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:jobboard/apis/auth.dart';
import 'package:jobboard/screens/auth_screens/LoginScreen.dart';
import 'package:jobboard/screens/auth_screens/OTPScreen.dart';
import 'package:jobboard/utils/helper.dart';
import 'package:jobboard/utils/local_storage.dart';
import 'package:jobboard/widgets/bottom_widget.dart';
import 'package:jobboard/widgets/custom_button.dart';
import 'package:jobboard/widgets/custom_text_form_field.dart';
import 'package:jobboard/widgets/top_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgot-password';
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final LocalStorage localStorage = LocalStorage();

  TextEditingController emailController = TextEditingController();

  String email = '';

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  handleSubmit() {
    Navigator.pushNamed(context, OTPScreen.routeName);
    // FocusScope.of(context).unfocus();
    // setState(() {
    //   isLoading = true;
    // });

    // AuthService().requestRestEmail(email).then((data) async {
    //   print(data);
    //   if (data['status'] == 200) {
    //     Helper().showSnackBar(context, 'Login Successful', Colors.green);
    //     setState(() {
    //       isLoading = false;
    //     });
    //     Navigator.pushReplacementNamed(context, OTPScreen.routeName);
    //   } else {
    //     setState(() {
    //       isLoading = false;
    //     });
    //     Helper().showSnackBar(context, data['error'], Colors.red);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            top: -160,
            left: -30,
            child: TopWidget(screenWidth: screenSize.width),
          ),
          Positioned(
            bottom: -180,
            left: -40,
            child: BottomWidget(screenWidth: screenSize.width),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'JobBoard',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Reset Password',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Enter your email to continue',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 100),
                    CustomTextFormField(
                      width: width,
                      autofocus: true,
                      controller: emailController,
                      labelText: 'Email',
                      hintText: 'Email Address',
                      prefixIcon: Icons.email,
                      textCapitalization: TextCapitalization.none,
                      borderRadius: 10,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5),
                    CustomButton(
                      text: 'Submit',
                      isLoading: isLoading,
                      isDisabled: isLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          handleSubmit();
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              LoginScreen.routeName,
                            );
                          },
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
