import 'package:flutter/material.dart';

import '../providers/user_data_provider.dart';
import '../widgets/custom_gap.dart';
import '../widgets/job_tile.dart';
import '../widgets/show_all_btn.dart';
import 'main_screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String userId;
  late bool isApplicant, isOrganization;

  TextEditingController titleController = TextEditingController();

  bool isLoading = true;
  bool isError = false;
  String errorText = '';

  @override
  void initState() {
    super.initState();

    setState(() {
      userId = UserProvider().userData!.id.toString();
      isApplicant = UserProvider().userData!.isApplicant!;
      isOrganization = UserProvider().userData!.isOrganization!;
    });

    if (isApplicant == true) {
      fetchApplicantData();
    } else if (isOrganization == true) {
      fetchOrganizationData();
    } else {
      setState(() {
        isError = true;
        isLoading = false;
        errorText = 'Something went wrong';
      });
    }
  }

  fetchApplicantData() {
    setState(() {
      isLoading = false;
    });
  }

  fetchOrganizationData() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () async {
                  // setState(() {
                  //   isLoading = true;
                  // });
                  // await readTokensAndUser();
                },
                child: isError
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              errorText,
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : isApplicant
                        ? const ApplicantSection()
                        : const OrganizationSection(),
              ),
      ),
      // appBar: AppBar(
      //   title: const Text('JobBoard'),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         Navigator.pushNamed(context, ProfileScreen.routeName);
      //       },
      //       icon: const Icon(Icons.person),
      //     ),
      //     IconButton(
      //       onPressed: () {
      //         Navigator.pushNamed(context, SettingsScreen.routeName);
      //       },
      //       icon: const Icon(Icons.settings),
      //     ),
      //   ],
      // ),
      // drawer: Drawer(
      //   width: MediaQuery.of(context).size.width * 0.8,
      //   backgroundColor: Colors.white,
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       DrawerHeader(
      //         curve: Curves.easeIn,
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: const [
      //                 // Image.asset(
      //                 //   'assets/images/logo.png',
      //                 //   width: 40,
      //                 //   height: 40,
      //                 // ),
      //                 SizedBox(width: 10),
      //                 Text(
      //                   'JobBoard',
      //                   style: TextStyle(
      //                     fontSize: 28,
      //                     fontWeight: FontWeight.bold,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             const Text(
      //               'Find Job on the Go',
      //               style: TextStyle(
      //                 fontSize: 18,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.home, size: 24),
      //         title: const Text(
      //           'Home',
      //           style: TextStyle(
      //             fontSize: 16,
      //           ),
      //         ),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.person_2_outlined, size: 24),
      //         title: const Text(
      //           'Profile',
      //           style: TextStyle(
      //             fontSize: 16,
      //           ),
      //         ),
      //         onTap: () {
      //           // Navigator.pop(context);
      //           Navigator.pushNamed(context, ProfileScreen.routeName);
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(
      //           Icons.settings,
      //           size: 24,
      //         ),
      //         title: const Text(
      //           'Settings',
      //           style: TextStyle(
      //             fontSize: 16,
      //           ),
      //         ),
      //         onTap: () {
      //           // Navigator.pop(context);
      //           Navigator.pushNamed(context, SettingsScreen.routeName);
      //         },
      //       ),
      //       // ListTile(
      //       //   leading: const RotationTransition(
      //       //     turns: AlwaysStoppedAnimation(180 / 360),
      //       //     child: Icon(
      //       //       Icons.logout,
      //       //       color: Colors.red,
      //       //       size: 24,
      //       //     ),
      //       //   ),
      //       //   title: const Text(
      //       //     'Logout',
      //       //     style: TextStyle(
      //       //       fontSize: 16,
      //       //       color: Colors.red,
      //       //       fontWeight: FontWeight.bold,
      //       //     ),
      //       //   ),
      //       //   onTap: () {
      //       //     showDialog(
      //       //       context: context,
      //       //       builder: (BuildContext context) {
      //       //         return AlertDialog(
      //       //           title: const Text('Are you sure?'),
      //       //           content: const Text('Would you like to logout?'),
      //       //           actions: [
      //       //             TextButton(
      //       //               child: const Text('Cancel'),
      //       //               onPressed: () {
      //       //                 Navigator.of(context).pop();
      //       //               },
      //       //             ),
      //       //             TextButton(
      //       //               child: const Text('Logout'),
      //       //               onPressed: () {
      //       //                 localStorage
      //       //                     .clearData()
      //       //                     .then((value) => Navigator.pushNamed(
      //       //                           context,
      //       //                           LoginScreen.routeName,
      //       //                         ));
      //       //               },
      //       //             ),
      //       //           ],
      //       //         );
      //       //       },
      //       //     );
      //       //   },
      //       // ),
      //     ],
      //   ),
      // ),
    );
  }
}

class ApplicantSection extends StatefulWidget {
  const ApplicantSection({super.key});

  @override
  State<ApplicantSection> createState() => _ApplicantSectionState();
}

class _ApplicantSectionState extends State<ApplicantSection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: const Center(
                          child: Text(
                            "Jobs Opening",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: const Center(
                          child: Text(
                            "Django Engineer",
                            style: TextStyle(
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: const Center(
                          child: Text(
                            "Artificial Intelligence",
                            style: TextStyle(
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SearchScreen.routeName);
                      },
                      icon: const Icon(
                        Icons.search,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recent Jobs',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                JobTile(),
                JobTile(),
                JobTile(),
                JobTile(),
                ShowAll(),
              ],
            ),
          ),
          const GapWidget(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recommended for you',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                JobTile(),
                JobTile(),
                JobTile(),
                JobTile(),
                ShowAll(),
              ],
            ),
          ),
          const GapWidget(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'More jobs for you',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                JobTile(),
                JobTile(),
                JobTile(),
                JobTile(),
                ShowAll(),
              ],
            ),
          ),
          const GapWidget(),
        ],
      ),
    );
  }
}

class OrganizationSection extends StatefulWidget {
  const OrganizationSection({super.key});

  @override
  State<OrganizationSection> createState() => _OrganizationSectionState();
}

class _OrganizationSectionState extends State<OrganizationSection> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Organization Section',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
