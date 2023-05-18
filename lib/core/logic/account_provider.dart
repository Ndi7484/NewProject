import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/bottom_navigation/bottom_navigation.dart';

class Account {
  Account({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
    this.alamat,
  });
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phone;
  List<Alamat>? alamat = [];
}

class Alamat {
  Alamat({
    required this.alamatTitle,
    required this.alamatLengkap,
    required this.alamatDesk,
  });
  String alamatTitle;
  String alamatLengkap;
  String alamatDesk;
}

enum Auth {
  initial,
  authenticated,
  unauthenticated,
}

enum IsSignUp {
  initial,
  success,
  fail,
}

class AccountProvider extends ChangeNotifier {
  final List<Account> _listAccount = [
    Account(
        firstName: 'Ndimas',
        lastName: 'Eka',
        email: '211110750@students.mikroskil.ac.id',
        password: 'Ndi@#0750',
        phone: '081375722601'),
    Account(
        firstName: 'Junior',
        lastName: 'Chandra',
        email: '211112630@students.mikroskil.ac.id',
        password: 'Jun@#2630',
        phone: '081375722602'),
    Account(
        firstName: 'Marco',
        lastName: 'Kinno',
        email: '211110676@students.mikroskil.ac.id',
        password: 'Mar@#0676',
        phone: '081375722603'),
    Account(
        firstName: 'Admin',
        lastName: 'Admin',
        email: 'admin',
        password: 'admin',
        phone: '081375722604'),
  ];
  // Login purposes
  Account? _selectedAccount;
  Auth _isAuthenticated = Auth.unauthenticated;
  IsSignUp _isSignUp = IsSignUp.initial;

  // parameter handle purposes
  String paramFirstName = '';
  String paramLastName = '';
  String paramEmail = '';
  String paramPhone = '';
  String paramPassword = '';
  String paramConfirmPass = '';
  // error message
  String message = '';

  Account? get selectedAccount => _selectedAccount;
  Auth get isAuthenticated => _isAuthenticated;
  IsSignUp get isSignUp => _isSignUp;

  // checkAccount() to login to main page
  void checkAccount(context) {
    _isAuthenticated = Auth.initial;
    bool authSet = false;
    for (var el in _listAccount) {
      if ((el.email == paramEmail || el.phone == paramPhone) &&
          el.password == paramPassword) {
        _selectedAccount = el;
        resetParam();
        _isAuthenticated = Auth.authenticated;
        authSet = true;
        message = 'Succesful Login';
        notifyListeners();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavigationPage(),
          ),
        );
      }
    }
    if (!authSet) {
      _isAuthenticated = Auth.unauthenticated;
      message = 'Login Fail, Incorrect Email/Password..';
    }
  }

  // check is there an duplicate email, phone
  bool checkAdd(String email, String phone) {
    bool toReturn = false;
    // check duplicate
    for (var el in _listAccount) {
      if (el.email == email || el.phone == phone) {
        return toReturn;
      }
    }
    // there is no duplicate
    return !toReturn;
  }

  // add new Account in SignUp page
  void addAccount(String firstName, String lastName, String email, String phone,
      String password, String confirmPass) {
    _isSignUp = IsSignUp.initial;
    if (password == confirmPass && checkAdd(email, phone)) {
      _listAccount.add(Account(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          phone: phone));
      message = 'Succesfully SignUp';
      _isSignUp = IsSignUp.success;
      notifyListeners();
    } else {
      message = 'Fail SignUp, Email/Phone already used..';
      _isSignUp = IsSignUp.fail;
      notifyListeners();
    }
  }

  // reset parameter to ''
  void resetParam() {
    paramFirstName = '';
    paramLastName = '';
    paramEmail = '';
    paramPhone = '';
    paramPassword = '';
    paramConfirmPass = '';
    message = '';
  }
}
