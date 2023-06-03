import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => LoginpageState();
}

class LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Row(
        children: [
          Column(
            children: [Text("Login"), Text("Register here")],
          ),
          Column(
            children: [Text("Username"), Text("Pass"), Text("Email")],
          ),
                    Column(
            children: [Text("Login"), Text("Register here")],
          ),
          Column(
            children: [Text("Username"), Text("Pass"), Text("Email")],
          ),
                    Column(
            children: [Text("Login"), Text("Register here")],
          ),
        ],
      ),
    );
  }
}
