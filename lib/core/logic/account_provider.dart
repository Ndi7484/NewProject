import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:excel/excel.dart';
import 'package:flutter_application_1/features/bottom_navigation/bottom_navigation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'address_provider.dart';

class Account {
  Account({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
    required this.points,
    required this.pointsString,
    this.alamat,
  });
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phone;
  final int points;
  final String pointsString;
  List<Alamat>? alamat;
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
  // more info excel dev https://pub.dev/packages/excel
  List<Account> _listAccount = [];
  // load data from excel
  void readAccount() async {
    ByteData data = await rootBundle.load('assets/data/account.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    var table = excel.tables[excel.tables.keys.first];

    NumberFormat formatter = NumberFormat("#,###", "en_US");
    _listAccount = List.generate(
      table!.maxRows,
      (index) {
        var row = table.row(index);
        return Account(
          firstName: row[0]!.value.toString(),
          lastName: row[1]!.value.toString(),
          email: row[2]!.value.toString(),
          password: row[3]!.value.toString(),
          phone: row[4]!.value.toString(),
          points: int.parse(row[5]!.value.toString()),
          pointsString: formatter
              .format(int.parse(row[5]!.value.toString()))
              .toString()
              .replaceAll(',', '.'),
        );
      },
    );
    notifyListeners();
  }

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
  String currentHour = '';

  Account? get selectedAccount => _selectedAccount;
  Auth get isAuthenticated => _isAuthenticated;
  IsSignUp get isSignUp => _isSignUp;

  // checkAccount() to login to main page
  void checkAccount(context) async {
    _isAuthenticated = Auth.initial;
    bool authSet = false;
    for (var el in _listAccount) {
      if ((el.email == paramEmail || el.phone == paramPhone) &&
          el.password == paramPassword) {
        _selectedAccount = el;
        _isAuthenticated = Auth.authenticated;
        authSet = true;
        message = 'Succesful Login';
        notifyListeners();
        // get account alamat if there is, if nothing then is []
        _selectedAccount?.alamat =
            Provider.of<AddressProvider>(context, listen: false)
                .getAddress(paramEmail);
        currentTime();
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

  // check current time
  void currentTime() {
    int currentTime = DateTime.now().hour;
    // Determine if it's morning, noon, or night
    if (currentTime >= 5 && currentTime < 11) {
      currentHour = 'Morning';
    } else if (currentTime >= 11 && currentTime < 14) {
      currentHour = 'Afternoon';
    } else if (currentTime >= 14 && currentTime < 18) {
      currentHour = 'Evening';
    } else {
      currentHour = 'Night';
    }
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
          phone: phone,
          points: 0,
          pointsString: '0'));
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
    _isAuthenticated = Auth.unauthenticated;
    _selectedAccount = null;
    _listAccount = [];
    _isSignUp = IsSignUp.initial;
    paramFirstName = '';
    paramLastName = '';
    paramEmail = '';
    paramPhone = '';
    paramPassword = '';
    paramConfirmPass = '';
    message = '';
    currentHour = '';
  }
}
