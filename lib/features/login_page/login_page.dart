import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
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
      body: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
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
                    width: 500,
                    height: 600,
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
                          Padding(
                            padding: const EdgeInsets.only(top: 30, bottom: 30),
                            child: Image.asset('assets/etc/logo.png'),
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: const Text(
                              "Log In",
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 128, 128),
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.bold,
                                fontSize: 80,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: const Text(
                              "Please Sign In to Continue",
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 128, 128),
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
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
                          SizedBox(height: 10),
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
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Provider.of<AccountProvider>(context,
                                          listen: false)
                                      .checkAccount(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(16.0),
                                  minimumSize: Size(200, 50),
                                ),
                                child: (provAccount.isAuthenticated ==
                                        Auth.initial)
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        'Login',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          wordSpacing: 5,
                                          fontSize: 20,
                                        ),
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
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  "Forget you password?",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow,
                        letterSpacing: 1,
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
