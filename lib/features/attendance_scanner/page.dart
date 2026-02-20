import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:zxing2/zxing2.dart';

class AttendanceScanPage extends StatelessWidget {
  final int sessionId;

  const AttendanceScanPage({super.key, required this.sessionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Điểm danh"),
      ),
      body: Column(
        children: [
          Text("Previous: "),
          MobileScanner(
            onDetect: (result) {
              print(result.barcodes.first.rawValue);
            },
          ),
          Text("Mode selection"),
        ],
      ),
    );
  }
}
