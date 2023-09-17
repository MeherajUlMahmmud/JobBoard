import 'package:flutter/material.dart';
import 'package:jobboard/apis/user.dart';
import 'package:jobboard/screens/profile_screens/ManageCVScreen.dart';
import 'package:jobboard/screens/profile_screens/UpdateProfileScreen.dart';
import 'package:jobboard/screens/utility_screens/ImageViewScreen.dart';
import 'package:jobboard/utils/local_storage.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final LocalStorage localStorage = LocalStorage();
  Map<String, dynamic> user = {};
  Map<String, dynamic> tokens = {};

  bool isLoading = true;
  bool isError = false;
  String errorText = '';

  @override
  void initState() {
    super.initState();

    readTokensAndUser();
  }

  readTokensAndUser() async {
    tokens = await localStorage.readData('tokens');
    user = await localStorage.readData('user');

    setState(() {
      isLoading = false;
    });
  }

  fetchUserDetails() {
    setState(() {
      isLoading = true;
    });
    UserService()
        .getUserDetails(tokens['access'], user['uuid'])
        .then((data) async {
      print(data);
      if (data['status'] == 200) {
        await localStorage.writeData('user', data['data']);
        setState(() {
          user = data['data'];
          isLoading = false;
        });
      } else {
        setState(() {
          isError = true;
          errorText = data['error'];
        });
      }
    }).catchError((error) {
      setState(() {
        isError = true;
        errorText = error.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(
                    const Duration(seconds: 1),
                    () {
                      fetchUserDetails();
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: ImageFullScreenWrapperWidget(
                                dark: true,
                                child: Image.asset('assets/avatars/rdj.png'),
                                // child: Image.asset(imageFile!.path),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${user['applicant']['first_name']} ${user['applicant']['last_name']}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      UpdateProfileScreen.routeName,
                                    ).then((value) => {
                                          if (value == true) fetchUserDetails()
                                        });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Edit Profile',
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(width: 5.0),
                                        Icon(Icons.edit, size: 15)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey[300]!,
                            ),
                          ),
                          child: Row(
                            children: [
                              const Text(
                                "Career Preferences",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit_note_outlined,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey[300]!,
                            ),
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    ManageCVScreen.routeName,
                                  );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.contact_page_outlined,
                                        size: 22,
                                        color: Color(0xB316BFC4),
                                      ),
                                      SizedBox(width: 15),
                                      Text(
                                        "Uploaded CVs",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.chevron_right_sharp,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    ManageCVScreen.routeName,
                                  );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.contact_page_outlined,
                                        size: 22,
                                        color: Color(0xB316BFC4),
                                      ),
                                      SizedBox(width: 15),
                                      Text(
                                        "Created CVs",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.chevron_right_sharp,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Navigator.pushNamed(
                                  //   context,
                                  //   UpdateProfileScreen.routeName,
                                  // ).then((value) => {
                                  //       if (value == true) fetchUserDetails()
                                  //     });
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check_box_outlined,
                                        size: 22,
                                        color: Color(0xB316BFC4),
                                      ),
                                      SizedBox(width: 15),
                                      Text(
                                        "Favorite Jobs",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.chevron_right_sharp,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Navigator.pushNamed(
                                  //   context,
                                  //   UpdateProfileScreen.routeName,
                                  // ).then((value) => {
                                  //       if (value == true) fetchUserDetails()
                                  //     });
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.message_outlined,
                                        size: 22,
                                        color: Color(0xB316BFC4),
                                      ),
                                      SizedBox(width: 15),
                                      Text(
                                        "Opening Message",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.chevron_right_sharp,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Navigator.pushNamed(
                                  //   context,
                                  //   UpdateProfileScreen.routeName,
                                  // ).then((value) => {
                                  //       if (value == true) fetchUserDetails()
                                  //     });
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.switch_account_outlined,
                                        size: 22,
                                        color: Color(0xB316BFC4),
                                      ),
                                      SizedBox(width: 15),
                                      Text(
                                        "Switch Profile",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        'Switch to Recruiter',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.chevron_right_sharp,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Navigator.pushNamed(
                                  //   context,
                                  //   UpdateProfileScreen.routeName,
                                  // ).then((value) => {
                                  //       if (value == true) fetchUserDetails()
                                  //     });
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.settings_outlined,
                                        size: 22,
                                        color: Color(0xB316BFC4),
                                      ),
                                      SizedBox(width: 15),
                                      Text(
                                        "Settings",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.chevron_right_sharp,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const Divider(),
                        // Row(
                        //   children: [
                        //     Container(
                        //       padding: const EdgeInsets.all(15),
                        //       decoration: BoxDecoration(
                        //         color: Colors.black,
                        //         borderRadius: BorderRadius.circular(50),
                        //       ),
                        //       child: const Icon(
                        //         Icons.email,
                        //         size: 20,
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //     const SizedBox(width: 15),
                        //     SizedBox(
                        //       width: width * 0.8,
                        //       child: Text(
                        //         user['email'],
                        //         style: const TextStyle(fontSize: 18),
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // const Divider(),
                        // Row(
                        //   children: [
                        //     Container(
                        //       padding: const EdgeInsets.all(15),
                        //       decoration: BoxDecoration(
                        //         color: Colors.black,
                        //         borderRadius: BorderRadius.circular(50),
                        //       ),
                        //       child: const Icon(
                        //         Icons.phone,
                        //         size: 20,
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //     const SizedBox(width: 15),
                        //     SizedBox(
                        //       width: width * 0.8,
                        //       child: Text(
                        //         user['applicant']['phone_number'] ?? 'N/A',
                        //         style: const TextStyle(fontSize: 18),
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // const Divider(),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
