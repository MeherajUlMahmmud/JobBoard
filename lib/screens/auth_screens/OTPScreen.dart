import 'package:flutter/material.dart';
import 'package:jobboard/screens/auth_screens/LoginScreen.dart';
import 'package:jobboard/widgets/bottom_widget.dart';
import 'package:jobboard/widgets/custom_button.dart';
import 'package:jobboard/widgets/top_widget.dart';

class OTPScreen extends StatefulWidget {
  static const routeName = '/otp';
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController opt1Controller = TextEditingController();
  TextEditingController opt2Controller = TextEditingController();
  TextEditingController opt3Controller = TextEditingController();
  TextEditingController opt4Controller = TextEditingController();
  TextEditingController opt5Controller = TextEditingController();
  TextEditingController opt6Controller = TextEditingController();

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    opt1Controller.dispose();
    opt2Controller.dispose();
    opt3Controller.dispose();
    opt4Controller.dispose();
    opt5Controller.dispose();
    opt6Controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP'),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width * 0.13,
                          child: TextFormField(
                            controller: opt1Controller,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            onChanged: (value) {
                              if (value.isEmpty) {
                                return;
                              }
                              if (int.tryParse(value) == null) {
                                opt1Controller.text = '';
                                return;
                              }
                              opt1Controller.text = value;
                              _formKey.currentState!.validate();
                              FocusScope.of(context).nextFocus();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Error';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: width * 0.13,
                          child: TextFormField(
                            controller: opt2Controller,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            onChanged: (value) {
                              if (value.isEmpty) {
                                return;
                              }
                              if (int.tryParse(value) == null) {
                                opt2Controller.text = '';
                                return;
                              }
                              opt2Controller.text = value;
                              _formKey.currentState!.validate();
                              FocusScope.of(context).nextFocus();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Error';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: width * 0.13,
                          child: TextFormField(
                            controller: opt3Controller,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            onChanged: (value) {
                              if (value.isEmpty) {
                                return;
                              }
                              if (int.tryParse(value) == null) {
                                opt3Controller.text = '';
                                return;
                              }
                              opt3Controller.text = value;
                              _formKey.currentState!.validate();
                              FocusScope.of(context).nextFocus();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Error';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: width * 0.13,
                          child: TextFormField(
                            controller: opt4Controller,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            onChanged: (value) {
                              if (value.isEmpty) {
                                return;
                              }
                              if (int.tryParse(value) == null) {
                                opt4Controller.text = '';
                                return;
                              }
                              opt4Controller.text = value;
                              _formKey.currentState!.validate();
                              FocusScope.of(context).nextFocus();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Error';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: width * 0.13,
                          child: TextFormField(
                            controller: opt5Controller,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            onChanged: (value) {
                              if (value.isEmpty) {
                                return;
                              }
                              if (int.tryParse(value) == null) {
                                opt5Controller.text = '';
                                return;
                              }
                              opt5Controller.text = value;
                              _formKey.currentState!.validate();
                              FocusScope.of(context).nextFocus();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Error';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: width * 0.13,
                          child: TextFormField(
                            controller: opt6Controller,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            onChanged: (value) {
                              if (value.isEmpty) {
                                return;
                              }
                              if (int.tryParse(value) == null) {
                                opt6Controller.text = '';
                                return;
                              }
                              opt6Controller.text = value;
                              _formKey.currentState!.validate();
                              FocusScope.of(context).nextFocus();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Error';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    CustomButton(
                      text: 'Submit',
                      isLoading: isLoading,
                      isDisabled: isLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // handleSubmit();
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
