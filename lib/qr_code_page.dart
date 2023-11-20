import 'package:flutter/material.dart';

class QrcidePage extends StatelessWidget {
  const QrcidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.all(16),
            child: Icon(
              Icons.notifications_on_outlined,
            ),
          )
        ],
        automaticallyImplyLeading: false,
        title: const Text('Scan Attendant'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Show Your Qrcode To Security',),
            Icon(
              Icons.qr_code_2_sharp,
              size: 350,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
