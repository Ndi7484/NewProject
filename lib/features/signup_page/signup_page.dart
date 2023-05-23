import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final provAccount = Provider.of<AccountProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(4.0),
                  width: MediaQuery.of(context).size.width * 0.375,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        provAccount.paramFirstName = value;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'First Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4.0),
                  width: MediaQuery.of(context).size.width * 0.375,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        provAccount.paramLastName = value;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Last Name',
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(4.0),
              width: MediaQuery.of(context).size.width * 0.75,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    provAccount.paramEmail = value;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4.0),
              width: MediaQuery.of(context).size.width * 0.75,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    provAccount.paramPhone = value;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4.0),
              width: MediaQuery.of(context).size.width * 0.75,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    provAccount.paramPassword = value;
                  });
                },
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4.0),
              width: MediaQuery.of(context).size.width * 0.75,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    provAccount.paramConfirmPass = value;
                  });
                },
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm Password',
                ),
              ),
            ),
            // button sign up here
            Container(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<AccountProvider>(context, listen: false)
                      .checkAccount(context);
                },
                child: (provAccount.isAuthenticated == Auth.initial)
                    ? const CircularProgressIndicator()
                    : const Text('Sign Up'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
