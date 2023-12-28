import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/state/analytic_helper.dart';
import 'package:flutter_application_1/core/widgets/notif_banner.dart';
import 'package:flutter_application_1/features/bottom_navigation/bottom_navigation.dart';
import 'package:flutter_application_1/features/newpass_page/newpass_page.dart';
import 'package:flutter_application_1/features/verification_page/verification_page.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account {
  Account({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
    required this.points,
    required this.pointsString,
    // this.alamat,
    required this.dateBirth,
  });
  final String firstName;
  final String lastName;
  final String email;
  String password;
  final String phone;
  int points;
  String pointsString;
  // List<Alamat>? alamat;
  DateTime dateBirth;

  Map<String, dynamic> toJson() => {
        'birth': Timestamp.fromDate(dateBirth),
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'pass': password,
        'phone': phone,
        'points': points,
      };

  static Account fromJson(Map<String, dynamic> json) => Account(
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        password: json['pass'],
        phone: json['phone'],
        points: json['points'],
        pointsString: json['points'].toString(),
        dateBirth: (json['birth'] as Timestamp).toDate(),
      );
}

enum Authion {
  initial,
  authenticated,
  unauthenticated,
}

enum IsSignUp {
  initial,
  success,
  fail,
}

enum Forget {
  initial,
  success,
  fail,
}

class AccountProvider extends ChangeNotifier {
  // more info excel dev https://pub.dev/packages/excel
  // change formater
  NumberFormat formatter = NumberFormat("#,###", "en_US");
  final AnalyticHelper analytic = AnalyticHelper();

  final Stream<List<Account>> _listAccount = FirebaseFirestore.instance
      .collection('account')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Account.fromJson(doc.data())).toList());

  void notifyme() {
    notifyListeners();
  }

  // Login purposes
  Account? _selectedAccount;
  Authion _isAuthenticated = Authion.unauthenticated;
  IsSignUp _isSignUp = IsSignUp.success;
  Forget _isForget = Forget.success;

  // parameter handle purposes
  String paramFirstName = '';
  String paramLastName = '';
  String paramEmail = '';
  String paramPhone = '';
  String paramPassword = '';
  String paramConfirmPass = '';
  DateTime? paramBirthDate;
  // error message
  String message = '';
  String currentHour = '';

  // verification digits 4
  String _validateParam = '';
  String paramV1 = '';
  String paramV2 = '';
  String paramV3 = '';
  String paramV4 = '';
  void resetValidation() {
    _validateParam = '';
    paramV1 = '';
    paramV2 = '';
    paramV3 = '';
    paramV4 = '';
    notifyListeners();
  }

  Account? get selectedAccount => _selectedAccount;
  Authion get isAuthenticated => _isAuthenticated;
  IsSignUp get isSignUp => _isSignUp;
  Forget get isForget => _isForget;

  // sharedpreferences variable
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPass = TextEditingController();
  final String _keyEmail = 'keyEmail';
  final String _keyPassword = 'keyPass';
  late SharedPreferences prefs;

  Future<String?> getSavedEmail() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }

  Future<String?> getSavedPass() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPassword);
  }

  void tryFirst(context) async {
    try {
      prefs = await SharedPreferences.getInstance();
      controllerEmail.text = prefs.getString(_keyEmail)!;
      controllerPass.text = prefs.getString(_keyPassword)!;
      paramEmail = prefs.getString(_keyEmail)!;
      paramPassword = prefs.getString(_keyPassword)!;
      notifyListeners();
      checkAccount(context);
    } catch (e) {
      print(e);
    }
  }

  // checkAccount() to login to main page
  void checkAccount(context) async {
    _isAuthenticated = Authion.initial;
    bool authSet = false;

    if (paramEmail == '' && paramPhone == '') {
      message = 'Please input the required email/password';
      _isAuthenticated = Authion.unauthenticated;
      notifyListeners();
      return;
    }

    // Subscribe to the stream and handle data as it arrives
    _listAccount.listen((account) async {
      for (var el in account) {
        if (el.email == paramEmail || el.phone == paramPhone) {
          _selectedAccount = el;

          // set sharedPrefereces saved
          prefs = await SharedPreferences.getInstance();
          if (paramEmail != '' && paramPassword != '') {
            prefs.setString(_keyEmail, paramEmail);
            prefs.setString(_keyPassword, paramPassword);
            paramEmail = prefs.getString(_keyEmail)!;
            paramPassword = prefs.getString(_keyPassword)!;
          }

          _isAuthenticated = Authion.authenticated;
          authSet = true;
          message = 'Succesful Login';
          // get account alamat if there is, if nothing then is [] or null
          // only works outside of this provider
          currentTime();
          notifyListeners();

          // analytic

          try {
            analytic.setUserId(paramEmail);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavigationPage(
                  selectNext: 0,
                ),
              ),
            );
          } catch (e) {}

          break;
        }
      }
      if (!authSet) {
        _isAuthenticated = Authion.unauthenticated;
        message = 'Login Fail, Incorrect Email/Password..';
        notifyListeners();
      }
    });
  }

  // check is there an duplicate email, phone
  Future<bool> checkAdd(String email, String phone) async {
    bool toReturn = true; // Default to true, assuming no duplicates

    await for (var accounts in _listAccount) {
      for (var el in accounts) {
        if (el.email == email || el.phone == phone) {
          toReturn = false; // Set to false if a duplicate is found
          break; // No need to continue checking once a duplicate is found
        }
      }
    }

    return toReturn;
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
  void addAccount(context) async {
    _isSignUp = IsSignUp.initial;
    notifyListeners();
    if (paramFirstName == '' ||
        paramLastName == '' ||
        paramEmail == '' ||
        paramPhone == '' ||
        paramPassword == '' ||
        paramConfirmPass == '' ||
        paramBirthDate == null) {
      message = 'Please input valid data';
      _isSignUp = IsSignUp.fail;
      notifyListeners();
      return;
    }
    if (paramFirstName.length < 3 || paramLastName.length < 3) {
      message = 'Name must at least 3 in length';
      _isSignUp = IsSignUp.fail;
      notifyListeners();
      return;
    }
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(paramEmail)) {
      message = 'Invalid email, must like **@**.**';
      _isSignUp = IsSignUp.fail;
      notifyListeners();
      return;
    }
    if (!RegExp(r'^[+]?[0-9]{9,13}$').hasMatch(paramPhone)) {
      message = 'Invalid phone, at least 9 in length with digits only';
      _isSignUp = IsSignUp.fail;
      notifyListeners();
      return;
    }
    if (paramPassword.length < 8) {
      message = 'Password at least eight in length';
      _isSignUp = IsSignUp.fail;
      notifyListeners();
      return;
    }
    if (paramPassword != paramConfirmPass) {
      message = "Password didn't match";
      _isSignUp = IsSignUp.fail;
      notifyListeners();
      return;
    }
    if (paramPassword == paramConfirmPass &&
        await checkAdd(paramEmail, paramPhone)) {
      var tmp = FirebaseFirestore.instance.collection('account').doc();
      var json = {
        'birth': Timestamp.fromDate(paramBirthDate!),
        'email': paramEmail,
        'first_name': paramFirstName,
        'last_name': paramLastName,
        'pass': md5.convert(utf8.encode(paramPassword)).toString(),
        'phone': paramPhone,
        'points': 0,
      };
      // await firebase set
      await tmp.set(json);
      resetParam();
      // readAccount();
      message = 'Succesfully SignUp';
      _isSignUp = IsSignUp.success;
      notifyListeners();
      Navigator.pop(context);
    } else {
      message = 'Fail SignUp, Email/Phone already used..';
      _isSignUp = IsSignUp.fail;
      notifyListeners();
    }
  }

  // check that user forget account
  void checkForget(context) async {
    _isForget = Forget.initial;
    if (paramEmail != '' || paramPhone != '') {
      _listAccount.listen((account) {
        bool isFind = false;
        for (var el in account) {
          if (el.email == paramEmail) {
            // there is an account named:
            paramEmail = el.email;
            isFind = true;
            _isForget = Forget.success;

            // code validation
            final random = Random();
            const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
            const length = 4;

            // do a code randomizer
            String randomString = '';
            for (int i = 0; i < length; i++) {
              randomString += chars[random.nextInt(chars.length)];
            }
            _validateParam = randomString;

            // show notif banner
            var bannerNotif = NotifBanner();
            ScaffoldMessenger.of(context).showMaterialBanner(
              bannerNotif.getBanner(context, randomString),
            );

            // set timer
            Timer(const Duration(seconds: 7), () {
              bannerNotif.changeView(context);
            });

            // push to next page validate?
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const VerificationPage()));
          }
          if (el.phone == paramPhone) {
            // there is an account named:
            paramPhone = el.phone;
            isFind = true;
            _isForget = Forget.success;

            // code validation
            final random = Random();
            const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
            const length = 4;

            // do a code randomizer
            String randomString = '';
            for (int i = 0; i < length; i++) {
              randomString += chars[random.nextInt(chars.length)];
            }
            _validateParam = randomString;

            // show notif banner
            var bannerNotif = NotifBanner();
            ScaffoldMessenger.of(context).showMaterialBanner(
              bannerNotif.getBanner(context, randomString),
            );

            // set timer
            Timer(const Duration(seconds: 7), () {
              bannerNotif.changeView(context);
            });

            // push to next page validate?
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const VerificationPage()));
          }
        }
        if (!isFind) {
          message = 'There is no such email/phone';
          _isForget = Forget.fail;
          notifyListeners();
        }
      });
    } else {
      message = 'Please input the email/phone';
      _isForget = Forget.fail;
      notifyListeners();
    }
  }

  //check code validation
  void checkValidation(context) {
    _isForget = Forget.initial;
    if ('$paramV1$paramV2$paramV3$paramV4' == _validateParam) {
      // success validate
      _isForget = Forget.success;
      paramPassword = '';
      paramConfirmPass = '';
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const NewPassPage()));
    } else {
      _isForget = Forget.fail;
      message = 'wrong validation code..';
      notifyListeners();
    }
  }

  // change new password
  void changeNewPass(context) async {
    _isForget = Forget.initial;
    message = '';
    if (paramConfirmPass.length < 8) {
      message = 'password must 8 in length';
      notifyListeners();
      return;
    }
    if (paramConfirmPass == '' || paramPassword == '') {
      message = 'please input your new password';
      _isForget = Forget.fail;
      return;
    } else {
      if (paramConfirmPass != paramPassword) {
        message = 'please type the same confirm password';
        _isForget = Forget.fail;
        return;
      }

      _listAccount.listen((account) {
        bool isFind = false;
        for (var el in account) {
          if (el.email == paramEmail || el.phone == paramPhone) {
            el.password = paramPassword;
            resetParam();
            isFind = true;
            message = 'password successfuly changed';
            notifyListeners();
            _isForget = Forget.success;
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        }
        if (!isFind) {
          message = 'error system to confirm';
          notifyListeners();
          return;
        }
      });
    }
  }

  void pointsChange(
      Account selectedAccount, int pointsMuch, int pointsGet) async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('account').get();

    WriteBatch batch = FirebaseFirestore.instance.batch();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;

      // Check if data is not null and is of type Map<String, dynamic>
      final account = Account.fromJson(data);

      if (account.email == selectedAccount.email) {
        batch.update(
          FirebaseFirestore.instance.collection('account').doc(doc.id),
          {'points': account.points - pointsMuch + pointsGet},
        );
      }
    }

    // done and send
    await batch.commit();
    notifyListeners();
  }

  // reset parameter to ''
  Future<void> resetParam() async {
    _isAuthenticated = Authion.unauthenticated;
    _selectedAccount = null;
    _isSignUp = IsSignUp.success;
    _isForget = Forget.success;
    paramFirstName = '';
    paramLastName = '';
    paramEmail = '';
    paramPhone = '';
    paramPassword = '';
    paramConfirmPass = '';
    paramBirthDate = null;
    message = '';
    currentHour = '';
    paramV1 = '';
    paramV2 = '';
    paramV3 = '';
    paramV4 = '';
    _validateParam = '';
    prefs = await SharedPreferences.getInstance();
    prefs.setString(_keyEmail, '');
    prefs.setString(_keyPassword, '');
  }
}
