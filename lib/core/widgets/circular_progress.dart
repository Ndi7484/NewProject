import 'package:flutter/material.dart';

class CircularProgressPage extends StatelessWidget {
  CircularProgressPage({super.key, this.messageText});
  String? messageText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(messageText ?? 'Please wait initializing...'),
          ],
        ),
      ),
    );
  }
}
