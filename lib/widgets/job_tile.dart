import 'package:flutter/material.dart';

class JobTile extends StatelessWidget {
  const JobTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade200,
              ),
              color: Colors.grey.shade200,
            ),
            child: Image.network(
              'https://images.unsplash.com/photo-1496200186974-4293800e2c20?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2064&q=80',
              width: 70,
              height: 70,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 20),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Django Developer',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Company Name',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Location',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Text('8 hours ago'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
