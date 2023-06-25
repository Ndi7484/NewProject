import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class EWalletPage extends StatefulWidget {
  const EWalletPage({super.key});

  @override
  State<EWalletPage> createState() => _EWalletPageState();
}

class _EWalletPageState extends State<EWalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        title: Text(
          "Konfirmasi Pembayaran",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/etc/lightgrey.png'),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  color: Colors.white),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, right: 5.0, left: 5.0, bottom: 15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.store_mall_directory_outlined,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "RANDUMU",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                letterSpacing: 0.5),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: Colors.grey[200]!, width: 1))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, bottom: 5, left: 5, right: 5),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 4,
                              child: Text(
                                "Total Pembayaran",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 165, 165, 165),
                                    fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Lihat Detail",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 62, 206, 206),
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, right: 5.0, left: 5.0, bottom: 30.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Rp",
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold)),
                        Text(
                          " 10.000",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 400,
            ),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.purple[900]!,
                    ),
                    color: Colors.purple[800],
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 200.0, left: 200.0, top: 15, bottom: 15),
                  child: Text(
                    "Bayar",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Batas waktu pembayaran 30 detik"),
            )
          ],
        ),
      ),
    );
  }
}
