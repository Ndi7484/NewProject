import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SyaratKetentuan extends StatefulWidget {
  const SyaratKetentuan({super.key});

  @override
  State<SyaratKetentuan> createState() => _SyaratKetentuanState();
}

class _SyaratKetentuanState extends State<SyaratKetentuan> {
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Syarat dan Ketentuan'),
          content: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: '- Promo makanan hingga xxx%',
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: '- Voucher hanya berlaku untuk layanan TakeAway dan Delivery, tidak untuk Dine In',
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: '- Voucher hanya bisa digunakan untuk memesan menu Dessert',
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }
  
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Syarat dan Ketentuan'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              _showDialog();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: '- Promo makanan hingga xxx%',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
            ),
            RichText(
              text: TextSpan(
                text: '- Voucher hanya berlaku untuk layanan TakeAway dan Delivery, tidak untuk Dine In',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
            ),
            RichText(
              text: TextSpan(
                text: '- Voucher hanya bisa digunakan untuk memesan menu Dessert',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
