import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/code_scan_provider.dart';
import 'package:flutter_application_1/core/logic/page_provider.dart';
import 'package:flutter_application_1/core/widgets/circular_progress.dart';
import 'package:flutter_application_1/features/cart_page/cart_page.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_application_1/core/logic/orders_provider.dart';

import 'widgets/bottom_cant_scan.dart';

class QRViewPage extends StatefulWidget {
  final OrdersProvider provOrders;
  final CodeScanProvider provCode;
  final bool tocart;
  const QRViewPage({Key? key, required this.provOrders, required this.tocart, required this.provCode})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewPageState();
}

class _QRViewPageState extends State<QRViewPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var bottom_cant = CantScanBottomSheet();

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    final provPage = Provider.of<PageProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        provPage.selectedIndex = 0;
        return true;
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    (result != null)
                        ? Text(result!.code!)
                        : const Text('Scan a code'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(16),
                          child: ElevatedButton(
                              onPressed: () async {
                                await controller?.toggleFlash();
                                setState(() {});
                              },
                              child: FutureBuilder(
                                future: controller?.getFlashStatus(),
                                builder: (context, snapshot) {
                                  return Row(
                                    children: [
                                      Icon((snapshot.data ?? false)
                                          ? Icons.flash_on
                                          : Icons.flash_off),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                          'Flash: ${(snapshot.data ?? false) ? 'on' : 'off'}'),
                                    ],
                                  );
                                },
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 4,
                child: Stack(children: [
                  _buildQrView(context),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.06,
                    left: MediaQuery.of(context).size.width * 0.35,
                    child: GestureDetector(
                        onTap: () {
                          bottom_cant.getBottomSheet(
                              context, mounted, widget.tocart, widget.provOrders, widget.provCode);
                        },
                        child: const Text(
                          "Can't Scan?",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )),
                  )
                ])),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 230.0
        : 350.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        widget.provOrders.paramDineInCode = scanData.code!;
      });

      // Delay the pop operation by 500 milliseconds (optional)
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          if (widget.tocart) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => CircularProgressPage()));
            Navigator.pop(context);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const CartPage()));
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => CircularProgressPage()));
            Navigator.pop(context);
          }
        }
      });
    });
  }

  // set permission to use camera
  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
