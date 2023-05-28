import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/features/login_page/login_page.dart';
import 'package:provider/provider.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key});

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 3; i++) {
      controllers[i].addListener(() {
        if (controllers[i].text.length == 1) {
          FocusScope.of(context).requestFocus(focusNodes[i + 1]);
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provAccount = Provider.of<AccountProvider>(context);
    final List provValue = [
      provAccount.paramV1,
      provAccount.paramV2,
      provAccount.paramV3,
      provAccount.paramV4
    ];
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
                            height: 20,
                          ),
                          Image.asset('assets/etc/Logo.png'),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Verification Code",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Enter a verification code, that we sent to ${(provAccount.paramEmail != '') ? 'email : ${provAccount.paramEmail}' : 'phone number : ${provAccount.paramPhone}'}",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),

                          // list 4 of focus node
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(4, (index) {
                              return Container(
                                padding: const EdgeInsets.all(8.0),
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: TextField(
                                  onTap: () {
                                    controllers[index].text = '';
                                  },
                                  controller: controllers[index],
                                  focusNode: focusNodes[index],
                                  onChanged: (value) {
                                    provValue[index] = value;
                                    // if (value.length > 1) {
                                    //   controllers[index].text =
                                    //       value.substring(0, 1);
                                    // }
                                  },
                                ),
                              );
                            }),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          GestureDetector(
                              onTap: () {
                                for (var controller in controllers) {
                                  controller.clear();
                                }
                                provAccount.resetValidation();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.clear_outlined,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'CLEAR',
                                    style: TextStyle(color: Colors.red),
                                  )
                                ],
                              )),

                          const SizedBox(
                            height: 40,
                          ),

                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                provAccount.paramV1 = controllers[0].text;
                                provAccount.paramV2 = controllers[1].text;
                                provAccount.paramV3 = controllers[2].text;
                                provAccount.paramV4 = controllers[3].text;
                                provAccount.checkValidation(context);
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(16.0),
                                minimumSize: const Size(150, 50),
                              ),
                              child:
                                  (provAccount.isAuthenticated == Auth.initial)
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
                          const SizedBox(
                            height: 15,
                          ),
                          (provAccount.message != '' &&
                                  provAccount.isForget != Forget.initial)
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
