import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BankTransferConfirmPaymentPage extends StatefulWidget {
  const BankTransferConfirmPaymentPage({super.key});

  @override
  State<BankTransferConfirmPaymentPage> createState() =>
      _BankTransferConfirmPaymentPageState();
}

class _BankTransferConfirmPaymentPageState
    extends State<BankTransferConfirmPaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Center(
            child: Text(
              "Back",
              style: TextStyle(
                  color: Colors.blue[400], fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          title: Center(
            child: Text(
              "m-Transfer",
              style: TextStyle(
                  color: Colors.blue[800], fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 10.0), // Adjust the left padding value as needed
              child: Icon(Icons.rectangle_rounded, color: Colors.green[300], size: 15),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 10.0), // Adjust the left padding value as needed
              child: Center(
                child: Text(
                  "Send",
                  style: TextStyle(
                    color: Colors.blue[400],
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/etc/Grey.png'),
            ),
          ),
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
                              color: Colors.blue[800],
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            "BCA",
                            style: TextStyle(fontWeight: FontWeight.bold),
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
                              color: Colors.blue[800],
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            "-SELECTED-",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,
                            color: Colors.blue[800]),
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
                              color: Colors.blue[800],
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            "-SELECTED-",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,
                            color: Colors.blue[800]),
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
                              color: Colors.blue[800],
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            "-SELECTED-",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,
                            color: Colors.blue[800]),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Dari Rekening",
                        style: TextStyle(
                            color: Colors.blue[800],
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
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
              const SizedBox(
                height: 230,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue[700]!,
                  ),
                  color: Colors.blue[700],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextButton(
                  onPressed: () {
                    // Handle button press
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 100.0, left: 100.0, top: 7, bottom: 7),
                    child: Text(
                      "Pay",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
