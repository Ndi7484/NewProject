import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/features/signup_page/signup_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final provAccount = Provider.of<AccountProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width * 0.5,
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
              padding: const EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width * 0.5,
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
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<AccountProvider>(context, listen: false)
                      .checkAccount(context);
                },
                child: (provAccount.isAuthenticated == Auth.initial)
                    ? const CircularProgressIndicator()
                    : const Text('Login'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            (provAccount.message != '')
                ? Container(
                    color: Theme.of(context).colorScheme.primary,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        provAccount.message,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                : Container(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member?",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    provAccount.resetParam();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ));
                  },
                  child: Text(
                    "Sign Up here",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
