import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new_outlined),
        ),
          title: Text("Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),),
          backgroundColor: Colors.red),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: CircleAvatar(
              radius: 70,
              backgroundColor: Colors.grey[200],
              child: Icon(
                Icons.person,
                size: 100,
                color: Colors.grey,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Guest1",
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 128, 128),
                      letterSpacing: 0.5,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Guestemail@gmail.com",
                  style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 0.5,
                      fontSize: 20,
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
                    Text(
                      "Name :  ",
                      style: TextStyle(
                          color: Colors.grey, letterSpacing: 0.5, fontSize: 20),
                    ),
                    Text(
                      "Guest 1",
                      style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 0.5,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
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
                    Text(
                      "Phone :  ",
                      style: TextStyle(
                          color: Colors.grey, letterSpacing: 0.5, fontSize: 20),
                    ),
                    Text(
                      "0812-4578-9632",
                      style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 0.5,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 15),
            child: Row(children: [
              Text(
                "Address: ",
                style: TextStyle(
                    color: Colors.grey, letterSpacing: 0.5, fontSize: 20),
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
                  Icons.home,
                  color: Colors.red,
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
                trailing: Icon(Icons.arrow_right_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
