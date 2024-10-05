import 'package:flutter/material.dart';

import '../../repositories/auth.dart';
import '../../utils/constants.dart';
import '../../utils/helper.dart';
import '../../widgets/bottom_widget.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/top_widget.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = Constants.signUpScreenRouteName;

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController organizationNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String userType = 'Applicant';

  String firstName = '';
  String lastName = '';
  String organizationName = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

  bool isObscure = true;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    organizationNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  handleSignUp() {
    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
    });

    if (userType == 'Applicant') {
      registerApplicant();
    } else {
      registerOrganization();
    }
  }

  registerApplicant() {
    AuthRepository()
        .registerApplicant(
      firstName,
      lastName,
      email,
      password,
    )
        .then((data) async {
      print(data);
      if (data['status'] == 200) {
        setState(() {
          isLoading = false;
        });

        Helper().showSnackBar(
          context,
          'Registration Successful',
          Colors.green,
        );

        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      } else {
        setState(() {
          isLoading = false;
        });
        Helper().showSnackBar(
          context,
          'Something went wrong',
          Colors.red,
        );
      }
    });
  }

  registerOrganization() {
    AuthRepository()
        .registerOrganization(
      organizationName,
      email,
      password,
    )
        .then((data) async {
      print(data);
      if (data['status'] == 200) {
        setState(() {
          isLoading = false;
        });

        Helper().showSnackBar(
          context,
          'Registration Successful',
          Colors.green,
        );

        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      } else {
        setState(() {
          isLoading = false;
        });
        Helper().showSnackBar(
          context,
          'Something went wrong',
          Colors.red,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
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
                      'Welcome',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Create an account to continue!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 240,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _formKey.currentState!.reset();
                              setState(() {
                                userType = "Applicant";
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: userType == "Applicant"
                                    ? const Color(0xB316BFC4)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                "Applicant",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _formKey.currentState!.reset();
                              setState(() {
                                userType = "Organization";
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: userType == "Organization"
                                    ? const Color(0xB316BFC4)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                "Organization",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    userType == "Applicant"
                        ? CustomTextFormField(
                            width: width,
                            autofocus: false,
                            controller: firstNameController,
                            labelText: 'First Name',
                            hintText: 'First Name',
                            prefixIcon: Icons.person,
                            textCapitalization: TextCapitalization.words,
                            borderRadius: 10,
                            keyboardType: TextInputType.name,
                            onChanged: (value) {
                              setState(() {
                                firstName = value;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                          )
                        : const SizedBox(),
                    userType == "Applicant"
                        ? CustomTextFormField(
                            width: width,
                            controller: lastNameController,
                            labelText: 'Last Name',
                            hintText: 'Last Name',
                            prefixIcon: Icons.person,
                            textCapitalization: TextCapitalization.words,
                            borderRadius: 10,
                            keyboardType: TextInputType.name,
                            onChanged: (value) {
                              setState(() {
                                lastName = value;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                          )
                        : const SizedBox(),
                    userType == "Organization"
                        ? CustomTextFormField(
                            width: width,
                            controller: organizationNameController,
                            labelText: 'Organization Name',
                            hintText: 'Organization Name',
                            prefixIcon: Icons.business_outlined,
                            textCapitalization: TextCapitalization.words,
                            borderRadius: 10,
                            keyboardType: TextInputType.name,
                            onChanged: (value) {
                              setState(() {
                                organizationName = value;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your organization name';
                              }
                              return null;
                            },
                          )
                        : const SizedBox(),
                    CustomTextFormField(
                      width: width,
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
                    CustomTextFormField(
                      width: width,
                      controller: passwordController,
                      labelText: 'Password',
                      hintText: 'Password',
                      prefixIcon: Icons.lock,
                      suffixIcon:
                          !isObscure ? Icons.visibility : Icons.visibility_off,
                      textCapitalization: TextCapitalization.none,
                      borderRadius: 10,
                      keyboardType: TextInputType.visiblePassword,
                      isObscure: isObscure,
                      suffixIconOnPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      width: width,
                      controller: confirmPasswordController,
                      labelText: 'Confirm Password',
                      hintText: 'Confirm Password',
                      prefixIcon: Icons.lock,
                      suffixIcon:
                          !isObscure ? Icons.visibility : Icons.visibility_off,
                      textCapitalization: TextCapitalization.none,
                      borderRadius: 10,
                      keyboardType: TextInputType.visiblePassword,
                      isObscure: isObscure,
                      suffixIconOnPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          confirmPassword = value;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your confirm password';
                        } else if (value != password) {
                          return 'Password does not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomButton(
                      text: 'Sign Up as an $userType',
                      isLoading: isLoading,
                      isDisabled: isLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          handleSignUp();
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
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
