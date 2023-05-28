import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/features/login_page/login_page.dart';
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/etc/Background.png'),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Create your account",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          // start here is text field
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.325,
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      provAccount.paramFirstName = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12, 12, 12, 12),
                                    border: OutlineInputBorder(),
                                    labelText: 'First Name',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.325,
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      provAccount.paramLastName = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12, 12, 12, 12),
                                    border: OutlineInputBorder(),
                                    labelText: 'Last Name',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.68,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  provAccount.paramEmail = value;
                                });
                              },
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 12, 12, 12),
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.68,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  provAccount.paramPhone = value;
                                });
                              },
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 12, 12, 12),
                                border: OutlineInputBorder(),
                                labelText: 'Phone Number',
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.68,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  provAccount.paramPassword = value;
                                });
                              },
                              obscureText: true,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 12, 12, 12),
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.68,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  provAccount.paramConfirmPass = value;
                                });
                              },
                              obscureText: true,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 12, 12, 12),
                                border: OutlineInputBorder(),
                                labelText: 'Confirm Password',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Provider.of<AccountProvider>(context,
                                        listen: false)
                                    .checkAccount(context);
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(16.0),
                                minimumSize: const Size(150, 25),
                              ),
                              child:
                                  (provAccount.isAuthenticated == Auth.initial)
                                      ? const CircularProgressIndicator()
                                      : const Text(
                                          'Sign Up',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            wordSpacing: 5,
                                            fontSize: 18,
                                          ),
                                        ),
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
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 242, 121),
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
