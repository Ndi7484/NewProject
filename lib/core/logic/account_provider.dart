import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:excel/excel.dart';
import 'package:flutter_application_1/core/widgets/notif_banner.dart';
import 'package:flutter_application_1/features/bottom_navigation/bottom_navigation.dart';
import 'package:flutter_application_1/features/login_page/login_page.dart';
import 'package:flutter_application_1/features/newpass_page/newpass_page.dart';
import 'package:flutter_application_1/features/verification_page/verification_page.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
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
  String password;
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

enum Forget {
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
  IsSignUp _isSignUp = IsSignUp.success;
  Forget _isForget = Forget.success;

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
  Auth get isAuthenticated => _isAuthenticated;
  IsSignUp get isSignUp => _isSignUp;
  Forget get isForget => _isForget;

  // checkAccount() to login to main page
  void checkAccount(context) async {
    _isAuthenticated = Auth.initial;
    bool authSet = false;
    if (paramEmail == '' && paramPhone == '' && paramPassword == '') {
      message = 'Please input the required email/password';
      _isAuthenticated = Auth.unauthenticated;
      notifyListeners();
      return;
    }
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
      notifyListeners();
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
  void addAccount(context) async {
    _isSignUp = IsSignUp.initial;
    notifyListeners();
    if (paramPassword == paramConfirmPass && checkAdd(paramEmail, paramPhone)) {
      // ByteData data = await rootBundle.load('assets/data/account.xlsx');
      // var bytes =
      //     data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      // var excel = Excel.decodeBytes(bytes);
      // Sheet sheetObject = excel.tables[excel.tables.keys.first]!;
      // var maxRows = sheetObject.maxRows;
      // // start insert the parameters
      // var cell1 = sheetObject.cell(CellIndex.indexByString('A${maxRows}'));
      // cell1.value = paramFirstName;
      // var cell2 = sheetObject.cell(CellIndex.indexByString('B${maxRows}'));
      // cell2.value = paramLastName;
      // var cell3 = sheetObject.cell(CellIndex.indexByString('C${maxRows}'));
      // cell3.value = paramEmail;
      // var cell4 = sheetObject.cell(CellIndex.indexByString('D${maxRows}'));
      // cell4.value = paramPassword;
      // var cell5 = sheetObject.cell(CellIndex.indexByString('E${maxRows}'));
      // cell5.value = paramPhone;
      // var cell6 = sheetObject.cell(CellIndex.indexByString('F${maxRows}'));
      // cell6.value = 0;
      // var cell7 = sheetObject.cell(CellIndex.indexByString('G${maxRows}'));
      // cell7.value = '0';
      // // stop insert
      // // Get the documents directory for saving the modified file
      // Directory documentsDirectory = await getApplicationDocumentsDirectory();
      // String folderPath = '${documentsDirectory.path}/assets/data';
      // String filePath = path.join(folderPath, 'account.xlsx');

      // // Create the folder if it doesn't exist
      // Directory(folderPath).createSync(recursive: true);

      // // Save the modified Excel file to the documents directory
      // File modifiedFile = File(filePath);
      // await modifiedFile.writeAsBytes(excel.encode()!);

      _listAccount.add(Account(
          firstName: paramFirstName,
          lastName: paramLastName,
          email: paramEmail,
          password: paramPassword,
          phone: paramPhone,
          points: 0,
          pointsString: '0'));
      resetParam();
      // readAccount();
      message = 'Succesfully SignUp';
      _isSignUp = IsSignUp.success;
      notifyListeners();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginPage()));
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
      bool isFind = false;
      for (var el in _listAccount) {
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
      bool isFind = false;
      for (var el in _listAccount) {
        if (el.email == paramEmail || el.phone == paramPhone) {
          // ByteData data = await rootBundle.load('assets/data/account.xlsx');
          // var bytes =
          //     data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
          // var excel = Excel.decodeBytes(bytes);
          // var table = excel.tables[excel.tables.keys.first];

          // for (var i = 0; i < table!.maxRows; i++) {
          //   var row = table.row(i);
          //   if (row[2]!.value.toString() == paramEmail ||
          //       row[4]!.value.toString() == paramPhone) {
          //     Sheet sheetObject = excel['Sheet1'];
          //     var cell = sheetObject.cell(CellIndex.indexByString('D$i'));
          //     cell.value = paramPassword;
          //     // Save the updated Excel file
          //     var updatedBytes = excel.encode();
          //     // Overwrite the existing file
          //     var file = File('assets/data/account.xlsx');
          //     await file.writeAsBytes(updatedBytes!);
          //   }
          // }

          // readAccount();
          el.password = paramPassword;
          resetParam();
          isFind = true;
          message = 'password successfuly changed';
          notifyListeners();
          _isForget = Forget.success;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const LoginPage()));
        }
      }
      if (!isFind) {
        message = 'error system to confirm';
        notifyListeners();
        return;
      }
    }
  }

  // reset parameter to ''
  void resetParam() {
    _isAuthenticated = Auth.unauthenticated;
    _selectedAccount = null;
    // _listAccount = [];
    _isSignUp = IsSignUp.success;
    _isForget = Forget.success;
    paramFirstName = '';
    paramLastName = '';
    paramEmail = '';
    paramPhone = '';
    paramPassword = '';
    paramConfirmPass = '';
    message = '';
    currentHour = '';
    paramV1 = '';
    paramV2 = '';
    paramV3 = '';
    paramV4 = '';
    _validateParam = '';
  }
}
