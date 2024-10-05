import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/applicant.dart';
import '../../models/organization.dart';
import '../../models/user.dart';
import '../../providers/user_data_provider.dart';
import '../../providers/user_profile_provider.dart';
import '../../repositories/user.dart';
import '../../utils/constants.dart';
import '../../utils/helper.dart';
import 'manage_cv_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = Constants.profileScreenRouteName;

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserRepository userRepository = UserRepository();
  UserProvider userProvider = UserProvider();

  late UserProfileProvider userProfileProvider;

  bool isLoading = true;
  bool isError = false;
  String errorText = '';

  @override
  void initState() {
    super.initState();

    userProfileProvider = Provider.of<UserProfileProvider>(
      context,
      listen: false,
    );

    fetchUserProfile();
  }

  fetchUserProfile() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await userRepository.getUserProfile();

      if (response['status'] == Constants.httpOkCode) {
        final UserBase userBase =
            UserBase.fromJson(response['data']['user_data']);

        Applicant applicant;
        Organization organization;
        UserProfile userProfile;

        if (userBase.isApplicant == true) {
          applicant = Applicant.fromJson(response['data']['applicant_data']);
          userProfile = UserProfile(
            userData: userBase,
            applicantData: applicant,
          );
        } else {
          organization =
              Organization.fromJson(response['data']['organization_data']);
          userProfile = UserProfile(
            userData: userBase,
            organizationData: organization,
          );
        }

        userProfileProvider.setUserProfile(userProfile);
        setState(() {
          isLoading = false;
        });
      } else {
        if (Helper().isUnauthorizedAccess(response['status'])) {
          if (!mounted) return;
          Helper().showSnackBar(
            context,
            Constants.sessionExpiredMsg,
            Colors.red,
          );
          Helper().logoutUser(context);
        } else {
          setState(() {
            isError = true;
            errorText = response['error'];
          });
        }
      }
    } catch (error) {
      print('Error getting user profile: $error');
      if (!mounted) return;
      setState(() {
        isLoading = false;
        isError = true;
        errorText = 'Error getting user profile: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Constants.updateProfileScreenRouteName)
              .then((value) => {if (value == true) fetchUserProfile()});
        },
        child: const Icon(Icons.edit),
      ),
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
                      fetchUserProfile();
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: ListView(
                    children: [
                      const SizedBox(height: 10.0),
                      SizedBox(
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: userProfileProvider.userProfile.applicantData
                                      ?.profilePicture !=
                                  null
                              ? Image.network(
                                  userProfileProvider.userProfile.applicantData!
                                      .profilePicture!,
                                  height: 200.0,
                                )
                              : Image.asset(
                                  Constants.defaultAvatarPath,
                                  height: 200.0,
                                ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        '${userProfileProvider.userProfile.applicantData?.firstName} ${userProfileProvider.userProfile.applicantData?.lastName}',
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Divider(),
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
    );
  }
}
