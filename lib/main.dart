import 'dart:async';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:no_intenet/qr_code_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isConnected = false;
  late StreamSubscription<InternetConnectionStatus> _subscription;

  @override
  void initState() {
    super.initState();
    checkInternetConnection(); // Initial check
    // Periodically check the internet connection every 5 seconds
    _subscription = InternetConnectionChecker().onStatusChange.listen((status) {
      setState(() {
        isConnected = status == InternetConnectionStatus.connected;
        showInternetStatusAlert(isConnected);
      });
    });
  }

  Future<void> checkInternetConnection() async {
    final bool result = await InternetConnectionChecker().hasConnection;
    setState(() {
      isConnected = result;
    });
  }

  void showInternetStatusAlert(bool isConnected) {
    String message = isConnected ? 'Connected is successed' : 'Not Connected';
    Color color = isConnected ? Colors.green : Colors.red;
    String title = isConnected ? 'Connected' : 'Not Connected';

    IconData icon = isConnected ? Icons.check : Icons.warning;

    Flushbar(
      title: title,
      message: message,
      duration: const Duration(seconds: 3),
      backgroundColor: color,
      icon: Icon(
        icon,
        color: Colors.white,
      ),
    )..show(context).then((_) {
        if (isConnected) {
          navigateToAnotherScreen();
        }
      });
  }

  void navigateToAnotherScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const QrcidePage(),
      ),
    );
  }

  @override
  void dispose() {
    _subscription.cancel(); // Cancel the subscription to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Splach Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isConnected
                ? const Icon(
                    Icons.wifi_tethering,
                    size: 350,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.wifi_off_outlined,
                    size: 350,
                    color: Colors.red,
                  ),
            const Gap(20),
            Text(
              isConnected ? 'Connected' : 'Not Connected',
              style: TextStyle(
                fontSize: 24,
                color: isConnected ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
