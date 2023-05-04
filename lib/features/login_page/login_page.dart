import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/counter_proivider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final provCounter = Provider.of<CounterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Count:',
            ),
            GestureDetector(
              onTap: () {
                provCounter.resetZero();
              },
              child: Text(
                '${provCounter.count}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provCounter.incrementCount();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
