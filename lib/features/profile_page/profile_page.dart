import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/core/logic/address_provider.dart';
import 'package:flutter_application_1/core/widgets/address_listtile.dart';
import 'package:flutter_application_1/features/address_page/address_page.dart';
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
    final provAddress = Provider.of<AddressProvider>(context);
    // set address here
    provAddress.getAddress(provAccount.selectedAccount!.email);

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
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AddressPage()));
          },
          // it can be selected or null
          child: AddressListTile(
            alamat: provAddress.selectedAlamat,
            selection: false,
            slider: false,
            icon: true,
          ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Log Out",
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                )),
          ],
        ),
        // const Spacer(),
      ]),
    );
  }
}
