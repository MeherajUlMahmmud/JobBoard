import 'package:jobboard/providers/user_provider.dart';
import 'package:jobboard/screens/auth_screens/LoginScreen.dart';
import 'package:jobboard/screens/main_screens/SearchScreen.dart';
import 'package:jobboard/screens/profile_screens/ProfileScreen.dart';
import 'package:jobboard/screens/utility_screens/SettingsScreen.dart';
import 'package:jobboard/utils/helper.dart';
import 'package:jobboard/utils/local_storage.dart';
import 'package:jobboard/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:jobboard/widgets/custom_gap.dart';
import 'package:jobboard/widgets/job_tile.dart';
import 'package:jobboard/widgets/show_all_btn.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocalStorage localStorage = LocalStorage();
  Map<String, dynamic> user = {};
  Map<String, dynamic> tokens = {};

  TextEditingController titleController = TextEditingController();

  late List<dynamic> resumes = [];
  bool isLoading = true;
  bool isApplicant = false;
  bool isOrganiation = false;
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
    isApplicant = user['is_applicant'];
    isOrganiation = user['is_organization'];

    if (isApplicant == true) {
      fetchApplicantData();
    } else if (isOrganiation == true) {
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
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('JobBoard'),
      ),
      floatingActionButton: isApplicant == true
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, SearchScreen.routeName);
              },
              child: const Icon(
                Icons.search,
              ),
            )
          : FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, SearchScreen.routeName);
              },
              child: const Icon(
                Icons.add,
              ),
            ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.8,
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              curve: Curves.easeIn,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      // Image.asset(
                      //   'assets/images/logo.png',
                      //   width: 40,
                      //   height: 40,
                      // ),
                      SizedBox(width: 10),
                      Text(
                        'JobBoard',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'Find Job on the Go',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, size: 24),
              title: const Text(
                'Home',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_2_outlined, size: 24),
              title: const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // Navigator.pop(context);
                Navigator.pushNamed(context, ProfileScreen.routeName);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                size: 24,
              ),
              title: const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // Navigator.pop(context);
                Navigator.pushNamed(context, SettingsScreen.routeName);
              },
            ),
            // ListTile(
            //   leading: const RotationTransition(
            //     turns: AlwaysStoppedAnimation(180 / 360),
            //     child: Icon(
            //       Icons.logout,
            //       color: Colors.red,
            //       size: 24,
            //     ),
            //   ),
            //   title: const Text(
            //     'Logout',
            //     style: TextStyle(
            //       fontSize: 16,
            //       color: Colors.red,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            //   onTap: () {
            //     showDialog(
            //       context: context,
            //       builder: (BuildContext context) {
            //         return AlertDialog(
            //           title: const Text('Are you sure?'),
            //           content: const Text('Would you like to logout?'),
            //           actions: [
            //             TextButton(
            //               child: const Text('Cancel'),
            //               onPressed: () {
            //                 Navigator.of(context).pop();
            //               },
            //             ),
            //             TextButton(
            //               child: const Text('Logout'),
            //               onPressed: () {
            //                 localStorage
            //                     .clearData()
            //                     .then((value) => Navigator.pushNamed(
            //                           context,
            //                           LoginScreen.routeName,
            //                         ));
            //               },
            //             ),
            //           ],
            //         );
            //       },
            //     );
            //   },
            // ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  isLoading = true;
                });
                await readTokensAndUser();
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recent Jobs',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const JobTile(),
                const JobTile(),
                const JobTile(),
                const JobTile(),
                const ShowAll(),
              ],
            ),
          ),
          const GapWidget(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
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
    return const SingleChildScrollView();
  }
}
