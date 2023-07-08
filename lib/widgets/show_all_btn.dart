import 'package:flutter/material.dart';

class ShowAll extends StatelessWidget {
  const ShowAll({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(15.0),
        color: Colors.grey.shade200,
        child: Center(
          child: const Text(
            'Show all -->',
            style: TextStyle(
              fontSize: 18,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
