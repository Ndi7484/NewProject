import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/core/logic/address_provider.dart';
import 'package:flutter_application_1/core/widgets/address_listtile.dart';
import 'package:flutter_application_1/features/address_page/address_page.dart';
import 'package:flutter_application_1/features/login_page/login_page.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
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
    // provAddress.getAddress(provAccount.selectedAccount!.email);

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
                    "Name        :  ",
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
                    "Date Birth :  ",
                    style: TextStyle(
                        color: Colors.grey, letterSpacing: 0.5, fontSize: 15),
                  ),
                  Text(
                    "${provAccount.selectedAccount!.dateBirth.day.toString()}-${provAccount.selectedAccount!.dateBirth.month.toString()}-${provAccount.selectedAccount!.dateBirth.year.toString()}",
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
                    "Phone       :  ",
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
              "Address    : ",
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
            child: StreamBuilder<List<Alamat>>(
              stream: provAddress.listAlamat, // Use the stream directly here
              builder: (context, snapshot) {
                print(snapshot.data);
                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   // Handle loading state
                //   return const CircularProgressIndicator();
                // } else
                if (snapshot.hasError) {
                  // Handle error state
                  return Text('Error: ${snapshot.error}');
                } else {
                  // Handle data state
                  final listAlamat = snapshot.data ?? [];
                  if(provAddress.listSelectedAlamat.isEmpty){
                    provAddress.listSelectedAlamat = <Alamat>[];
                  }
                  // List<Alamat> selectedAlamat = [];
                  for (var el in listAlamat) {
                    if (el.alamatID == provAccount.selectedAccount!.email) {
                      provAddress.listSelectedAlamat.add(el);
                      // provAddress.selectedAlamat = el;
                    }
                  }
                  // try {
                  //   provAddress.selectedAlamat =
                  //       provAddress.listSelectedAlamat[0];
                  // } catch (e) {
                  //   print('wrong alamat or missing');
                  // }
                  return (listAlamat != [])
                      ? AddressListTile(
                          alamat: provAddress.selectedAlamat ??
                              Alamat(
                                  alamatID: 'None',
                                  alamatTitle: 'No Address',
                                  alamatLengkap: 'No Address',
                                  alamatDesk: 'No Address',
                                  alamatLang: 0,
                                  alamatLong: 0,
                                  alamatMapsDesc: 'No Address'),
                          selection: false,
                          slider: false,
                          icon: true,
                        )
                      : AddressListTile(
                          alamat: Alamat(
                              alamatID: 'None',
                              alamatTitle: 'No Address',
                              alamatLengkap: 'No Address',
                              alamatDesk: 'No Address',
                              alamatLang: 0,
                              alamatLong: 0,
                              alamatMapsDesc: 'No Address'),
                          selection: false,
                          slider: false,
                          icon: true);
                  // Now you can use listAlamat to display the data in your widget
                  // ...
                }
              },
            )),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
                onTap: () {
                  provAccount.resetParam();
                  provAddress.softReset();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const LoginPage()));
                  Flushbar(
                    flushbarPosition: FlushbarPosition.TOP,
                    messageText: const Text(
                      'Successfully Logout..',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    duration: const Duration(seconds: 2),
                  ).show(context);
                },
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
