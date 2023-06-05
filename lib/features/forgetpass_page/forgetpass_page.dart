import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/features/login_page/login_page.dart';
import 'package:provider/provider.dart';

class ForgetPassPage extends StatefulWidget {
  const ForgetPassPage({Key? key});

  @override
  _ForgetPassPageState createState() => _ForgetPassPageState();
}

class _ForgetPassPageState extends State<ForgetPassPage> {
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
                            height: 50,
                          ),
                          Text(
                            "Forget Password",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Text(
                            "Enter your Email / Phone Number:",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              // letterSpacing: 0.5,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  if (value.contains('@')) {
                                    provAccount.paramEmail = value;
                                  } else {
                                    provAccount.paramPhone = value;
                                  }
                                });
                              },
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 12, 12, 12),
                                border: OutlineInputBorder(),
                                labelText: 'Email / Phone Number',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                provAccount.checkForget(context);
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(16.0),
                                minimumSize: const Size(150, 50),
                              ),
                              child: (provAccount.isForget == Forget.initial)
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      'Continue',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        wordSpacing: 5,
                                        fontSize: 20,
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
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 5.0),
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
                        provAccount.resetParam();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginPage()));
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
