import 'package:flutter/material.dart';

class CircularProgressPage extends StatelessWidget {
  const CircularProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 8,
            ),
            const Text('Please wait...'),
          ],
        ),
      ),
    );
  }
}
