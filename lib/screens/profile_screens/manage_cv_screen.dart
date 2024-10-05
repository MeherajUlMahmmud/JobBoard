import 'package:flutter/material.dart';
import 'package:jobboard/utils/local_storage.dart';

class ManageCVScreen extends StatefulWidget {
  static const routeName = '/manage-cv';

  const ManageCVScreen({super.key});

  @override
  State<ManageCVScreen> createState() => _ManageCVScreenState();
}

class _ManageCVScreenState extends State<ManageCVScreen> {
  final LocalStorage localStorage = LocalStorage();
  Map<String, dynamic> user = {};
  Map<String, dynamic> tokens = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Your Resumes'),
        actions: [
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '1/3',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _cvItem(),
            _cvItem(),
            _cvItem(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 80,
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {
              // Navigator.of(context).pushNamed('/update-profile');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Upload a new CV',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _cvItem() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.picture_as_pdf, size: 50),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'CV Name',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Last updated: 1/1/2021',
                style: TextStyle(),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
