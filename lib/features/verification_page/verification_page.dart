import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/features/login_page/login_page.dart';
import 'package:flutter_application_1/features/signup_page/signup_page.dart';
import 'package:provider/provider.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key});

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
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
                    height: 640,
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
                            padding: const EdgeInsets.only(top: 30, bottom: 20),
                            child: Image.asset('assets/etc/logo.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 70),
                            child: Text(
                              "Verification Code",
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 128, 128),
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.bold,
                                fontSize: 50,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              "Enter Verification Code :",
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 128, 128),
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      provAccount.paramPhone = value;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      provAccount.paramPhone = value;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      provAccount.paramPhone = value;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      provAccount.paramPhone = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 120),
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
                                        'Continue',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          wordSpacing: 5,
                                          fontSize: 20,
                                        ),
                                      ),
                              ),
                            ),
                          ),
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
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Text(
                        "Back?",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => LoginPage()));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow,
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
