// ignore_for_file: non_constant_identifier_names

import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticHelper {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // {bread,[1,10000]}
  Map<String, List<int>> listEventItem = {};
  List<AnalyticsEventItem>? listEventItemConfirm;

  Future<void> eventLog(value) async {
    await analytics.logEvent(
      name: '${value}_click',
      parameters: {'value': value},
    );
    print('send event $value');
  }

  Future<void> setUserId(value) async {
    await analytics.setUserId(id: '$value');
    print('setUserId $value');
  }

  Future<void> userProperty() async {
    await analytics.setUserProperty(name: 'regular', value: 'indeed');
    print('setUserProperty succeeded');
  }

  // Sets the duration of inactivity that terminates the current session.
  // The default value is 1800000 milliseconds (30 minutes).
  Future<void> sessionTimeout() async {
    await analytics.setSessionTimeoutDuration(Duration(minutes: 60));
    print('session set timeout 60 min');
  }

  // Retrieves the app instance id from the service, or null if consent has been denied.
  Future<String?> appInstance() async {
    var result = await analytics.appInstanceId;
    print(result);
    print(result.runtimeType);
    return result;
  }

  // Clears all analytics data for this app from the device and resets the app instance id.
  // Future<void> resetAnalytics() async {
  //   await analytics.resetAnalyticsData();
  //   listEventItem = null;
  //   print('analytics reset');
  // }

  // This event signifies that a user has submitted their payment information to your app.
  Future<void> addPayment(String paymentType, int value) async {
    await analytics.logAddPaymentInfo(
        paymentType: paymentType, currency: 'Rupiah', value: value.toDouble());
    print('payment type : $paymentType');
    print('currency     : Rupiah');
    print('amount       : $value');
  }

  // This event signifies that an item was added to a cart for purchase.
  // Note: If you supply the [value] parameter, you must also supply the [currency] parameter so that revenue metrics can be computed accurately.
  Future<void> addToCart(String name, int amount, int price) async {
    Map<String, List<int>> tmp = {
      name: [((listEventItem[name]?[0] ?? 0) + amount), price]
    };
    listEventItem.addAll(tmp);
  }

  Future<void> confirmAddCart() async {
    var keys = listEventItem.keys.toList();
    List<AnalyticsEventItem> tmp = List.generate(
        keys.length,
        (index) => AnalyticsEventItem(
              itemName: keys[index],
              price: listEventItem[keys[index]]?[1],
              currency: 'Rupiah',
              quantity: listEventItem[keys[index]]?[0],
            ));
    var tmpVal = 0;
    for (var el in keys) {
      tmpVal = tmpVal.toInt() +
          listEventItem[el]![0].toInt() * listEventItem[el]![1].toInt();
    }
    listEventItemConfirm = tmp;
    await analytics.logAddToCart(
        items: tmp, value: tmpVal.toDouble(), currency: 'Rupiah');
  }

  Future<void> purchase() async {
    await analytics.logPurchase(
        currency: 'Rupiah', items: listEventItemConfirm);
    print('Purchase !!!');
    print('items purchased: $listEventItemConfirm');
    listEventItem = {};
    print('emptying list event item');
  }
}
