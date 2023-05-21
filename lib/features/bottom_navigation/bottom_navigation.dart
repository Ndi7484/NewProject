import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/features/login_page/login_page.dart';
import 'package:flutter_application_1/features/main_page/main_page.dart';
import 'package:flutter_application_1/features/menu_page/menu_page.dart';
import 'package:provider/provider.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _selectedIndex = 0;
  final List<dynamic> _bodyFill = [
    const MainPage(),
    const MenuPage(),
    const MainPage(),
    const MainPage(),
    const MainPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final provAccount = Provider.of<AccountProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
      ),
      drawer: (_selectedIndex == 0)
          ? Drawer(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 45, 16, 16),
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: Theme.of(context).colorScheme.primary,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Customer :',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(width: 1, color: Colors.black),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100))),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/etc/Profile.png',
                                width: 70,
                                height: 70,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ('${provAccount.selectedAccount?.firstName ?? 'Randumu'} ${provAccount.selectedAccount?.lastName ?? 'Guest'}'
                                            .length >
                                        15)
                                    ? provAccount.selectedAccount?.firstName ??
                                        'Randumu'
                                    : '${provAccount.selectedAccount?.firstName ?? 'Randumu'} ${provAccount.selectedAccount?.lastName ?? 'Guest'}',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                ((provAccount.selectedAccount!.email.length >
                                            20)
                                        ? '${provAccount.selectedAccount!.email.substring(0, 20)}...'
                                        : provAccount.selectedAccount?.email) ??
                                    '<email?>',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    title: Text(
                      'Account',
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Address',
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  const Divider(
                    thickness: 2,
                  ),
                  const Text(
                    'Any Question, Contact Us :\n+62 813 1564 1235\n+62 813 4578 9200',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  ListTile(
                    title: const Text(
                      'Log Out',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                  ),
                ],
              ),
            )
          : null,
      body: Container(
        child: _bodyFill[_selectedIndex],
      ),
      floatingActionButton: (_selectedIndex == 1)
          ? FloatingActionButton(
              onPressed: () {},
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(
                Icons.shopping_basket,
                color: Colors.white,
              ))
          : null,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_dining_outlined), label: 'Menu'),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_rate_rounded), label: 'Points'),
          BottomNavigationBarItem(
              icon: Icon(Icons.discount_rounded), label: 'Promo'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_rounded), label: 'Orders'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
