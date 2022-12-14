import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:ihse/View/MonthlyInspection.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:ihse/Model/InspectionPart.dart';
import 'package:ihse/Model/equipmentChart.dart';

import '../shared/loading.dart';

class DailyInspection extends StatefulWidget {
  String inspectionType;
  int TotalScore;

  DailyInspection(this.inspectionType, this.TotalScore);

  @override
  State<DailyInspection> createState() =>
      _DailyInspectionState(inspectionType, TotalScore);
}

class _DailyInspectionState extends State<DailyInspection> {
  String inspectionType;
  int TotalScore;

  _DailyInspectionState(this.inspectionType, this.TotalScore);

  Barcode? barcode;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() {
    controller?.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/ihse.png',
          fit: BoxFit.cover,
          height: 50,
          width: 250,
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Colors.red,
            ],
          ),
        ),
        child: buildQRView(context),
        // child: SingleChildScrollView(
        //   child: Column(
        //     children: <Widget>[],
        //   ),
        // ),
      ),
    );
  }

  Widget buildQRView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          cutOutSize: MediaQuery.of(context).size.width * 0.5,
          borderLength: 30,
          borderRadius: 13,
          borderColor: Colors.blue,
          borderWidth: 10,
        ),
      );

  void onQRViewCreated(QRViewController controller) {
    controller.resumeCamera();
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen(
      (barcode) {
        setState(
          () {
            this.barcode = barcode;
          },
        );
        print(inspectionType);
        print(TotalScore);
        print(barcode.code.toString());

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MonthlyInspection(
              barcode.code.toString(),
              inspectionType,
              TotalScore,
            ),
          ),
        );
      },
    );
  }
}
