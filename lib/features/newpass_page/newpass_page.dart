import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:provider/provider.dart';

class NewPassPage extends StatefulWidget {
  const NewPassPage({Key? key});

  @override
  _NewPassPageState createState() => _NewPassPageState();
}

class _NewPassPageState extends State<NewPassPage> {
  bool _passwordInvisible = true;
  bool _passwordInvisible2 = true;
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
                            height: 20,
                          ),
                          Text(
                            "New Password",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Text(
                            "Enter your new password :",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      provAccount.paramPassword = value;
                                    });
                                  },
                                  obscureText: _passwordInvisible,
                                  decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12, 12, 42, 12),
                                    border: OutlineInputBorder(),
                                    labelText: 'New Password',
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 11.5,
                                right: 10,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _passwordInvisible = !_passwordInvisible;
                                    });
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    color: Colors.white,
                                    child: Icon(
                                      (_passwordInvisible)
                                          ? Icons.visibility
                                          : Icons.visibility_off_outlined,
                                      color: (provAccount.paramPassword != '')
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      provAccount.paramConfirmPass = value;
                                    });
                                  },
                                  obscureText: _passwordInvisible2,
                                  decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12, 12, 42, 12),
                                    border: OutlineInputBorder(),
                                    labelText: 'Confirm Password',
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 11.5,
                                right: 10,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _passwordInvisible2 =
                                          !_passwordInvisible2;
                                    });
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    color: Colors.white,
                                    child: Icon(
                                      (_passwordInvisible2)
                                          ? Icons.visibility
                                          : Icons.visibility_off_outlined,
                                      color:
                                          (provAccount.paramConfirmPass != '')
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                              : Colors.grey,
                                    ),
                                  ),
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
                                  provAccount
                                      .changeNewPass(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(16.0),
                                  minimumSize: const Size(150, 50),
                                ),
                                child: (provAccount.isAuthenticated ==
                                        Authion.initial)
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        'Done',
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
            ],
          ),
        ),
      ),
    );
  }
}
