
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrbasedauthenication/features/user/providers.dart';
import 'package:qrbasedauthenication/features/user/users_screen.dart';

class QrScanner extends StatelessWidget{
  const QrScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        ElevatedButton(onPressed: () async{
          final userId = await FlutterBarcodeScanner.scanBarcode(
              '#fffff',
              'Cancel',
              true,
            ScanMode.QR
              );
          if(userId.isNotEmpty){
           Navigator.push(
              context, MaterialPageRoute(builder: (context) => UsersScreen(userId: userId),)
                );
          }
        }, child: Text('Scan QR code to see the profile')),
      ],
    );
  }
}
