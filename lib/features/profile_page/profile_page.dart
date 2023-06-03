import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final provAccount = Provider.of<AccountProvider>(context);
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
          title: const Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 0.5, color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(100))),
              child: ClipOval(
                child: Image.asset(
                  'assets/etc/Profile.png',
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  '${provAccount.selectedAccount!.firstName.toString()} ${provAccount.selectedAccount!.lastName.toString()}',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      letterSpacing: 0.5,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  provAccount.selectedAccount!.email.toString(),
                  style: const TextStyle(
                      color: Colors.grey,
                      letterSpacing: 0.5,
                      fontSize: 17,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Name :  ",
                      style: TextStyle(
                          color: Colors.grey, letterSpacing: 0.5, fontSize: 15),
                    ),
                    Text(
                      "${provAccount.selectedAccount!.firstName.toString()} ${provAccount.selectedAccount!.lastName.toString()}",
                      style: const TextStyle(
                        color: Colors.black,
                        letterSpacing: 0.5,
                        fontSize: 15,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Phone :  ",
                      style: TextStyle(
                          color: Colors.grey, letterSpacing: 0.5, fontSize: 15),
                    ),
                    Text(
                      provAccount.selectedAccount!.phone.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        letterSpacing: 0.5,
                        fontSize: 15,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 15),
            child: Row(children: const [
              Text(
                "Address: ",
                style: TextStyle(
                    color: Colors.grey, letterSpacing: 0.5, fontSize: 15),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(
                  color: Colors.white,
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey, // Shadow color
                    spreadRadius: 2.0, // Spread radius
                    blurRadius: 5.0, // Blur radius
                    offset: Offset(0, 3), // Offset in the x and y direction
                  ),
                ],
              ),
              child: ListTile(
                leading: Icon(
                  Icons.home_rounded,
                  color: Colors.red,
                  size: 40,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Home",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text("Address"),
                    ),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text("Detail address"),
                ),
                trailing: Icon(
                  Icons.arrow_right_outlined,
                  size: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
