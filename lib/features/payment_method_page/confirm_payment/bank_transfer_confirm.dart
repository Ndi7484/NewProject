import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/account_provider.dart';
import 'package:flutter_application_1/core/logic/history_provider.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';
import 'package:flutter_application_1/core/logic/page_provider.dart';
import 'package:flutter_application_1/core/logic/payment_provider.dart';
import 'package:flutter_application_1/core/state/analytic_helper.dart';
import 'package:flutter_application_1/core/widgets/circular_progress.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BankTransferConfirmPaymentPage extends StatefulWidget {
  BankTransferConfirmPaymentPage({
    super.key,
    required this.bankData,
  });
  Payment bankData;

  @override
  State<BankTransferConfirmPaymentPage> createState() =>
      _BankTransferConfirmPaymentPageState();
}

class _BankTransferConfirmPaymentPageState
    extends State<BankTransferConfirmPaymentPage> {
  NumberFormat formmater = NumberFormat("#,###", "en_US");

  AnalyticHelper fbAnalytics = AnalyticHelper();

  late InterstitialAd _interstitialAd;
  bool _isInterstitialReady = false;

  @override
  void initState() {
    _loadInterstitialAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provOrders = Provider.of<OrdersProvider>(context);
    final provHistory = Provider.of<HistoryProvider>(context);
    final provAccount = Provider.of<AccountProvider>(context);
    final provPage = Provider.of<PageProvider>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Back",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
            ),
          ),
          title: Center(
            child: Text(
              "m-Transfer",
              style: TextStyle(
                  color: widget.bankData.color, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 10.0), // Adjust the left padding value as needed
              child: Icon(Icons.rectangle_rounded,
                  color: Colors.green[300], size: 15),
            ),
            const Padding(
              padding: EdgeInsets.only(
                  right: 10.0), // Adjust the left padding value as needed
              child: Center(
                child: Text(
                  "Send",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
            ),
          ],
        ),
        body: Container(
          color: Colors.grey,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Colors.white),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(color: Colors.grey[300]!, width: 1.0),
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          "Bank",
                          style: TextStyle(
                              color: widget.bankData.color,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            widget.bankData.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          "Ke Rekening Tujuan",
                          style: TextStyle(
                              color: widget.bankData.color,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            "-SELECTED-",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,
                            color: widget.bankData.color),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(color: Colors.grey[300]!, width: 1.0),
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          "Jumlah Uang",
                          style: TextStyle(
                              color: widget.bankData.color,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            formmater
                                .format(provOrders.tmpOrdersCartHistory!.totals)
                                .toString()
                                .replaceAll(',', '.'),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,
                            color: widget.bankData.color),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(color: Colors.grey[300]!, width: 1.0),
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          "Layanan Transfer",
                          style: TextStyle(
                              color: widget.bankData.color,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            "-SELECTED-",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,
                            color: widget.bankData.color),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Dari Rekening",
                        style: TextStyle(
                            color: widget.bankData.color,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          "112233445566",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: widget.bankData.color,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextButton(
                  onPressed: () async {
                    // analytics
                    fbAnalytics.purchase();
                    // Handle button press
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (_) => CircularProgressPage(
                    //               messageText:
                    //                   'Please wait, confirming payment..',
                    //             )));
                    await _loadInterstitialAd();
                    if (_isInterstitialReady) {
                      _interstitialAd.show();
                    }

                    // set history
                    final docHistory =
                        FirebaseFirestore.instance.collection('history').doc();
                    final json = provOrders.tmpOrdersCartHistory!.toJson();
                    docHistory.set(json);
                    // provHistory
                    //     .addListOrderHistory(provOrders.tmpOrdersCartHistory!);

                    provAccount.pointsChange(
                        provAccount.selectedAccount!,
                        provOrders.tmpOrdersCartHistory!.pointsMuch,
                        provOrders.tmpOrdersCartHistory!.pointsGet);
                    provPage.historyIndex =
                        (provOrders.tmpOrdersCartHistory!.typeOrder ==
                                TypeOrder.delivery)
                            ? 0
                            : (provOrders.tmpOrdersCartHistory!.typeOrder ==
                                    TypeOrder.takeaway)
                                ? 1
                                : 2;
                    provOrders.resetParam();
                    provPage.selectedIndex = 4;

                    // replace with pop til first after delay
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(
                        right: 100.0, left: 100.0, top: 7, bottom: 7),
                    child: Text(
                      "Pay",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ));
  }

  Future<void> _loadInterstitialAd() async {
    InterstitialAd.load(
      // adUnitId: 'ca-app-pub-9772301287720439/1604550076',
      adUnitId: 'ca-app-pub-3940256099942544/4411468910',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
            print('Close Interstitial Ad');
          });
          setState(() {
            _isInterstitialReady = true;
            _interstitialAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load interstitial ad: $err');
          setState(() {
            _isInterstitialReady = false;
            _interstitialAd.dispose();
          });
        },
      ),
    );
  }
}
