import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeCodeScreen extends StatefulWidget {
  NativeCodeScreen({Key? key}) : super(key: key);

  @override
  State<NativeCodeScreen> createState() => _NativeCodeScreenState();
}

class _NativeCodeScreenState extends State<NativeCodeScreen> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  // Get battery level.
  String batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    platform.invokeMethod('getBatteryLevel').then((value) {
      batteryLevel = 'Battery level at $value % .';
      setState(() {
        batteryLevel = batteryLevel;
      });
    }).catchError((error) {
      batteryLevel = "Failed to get battery level: '${error.message}'.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: const Text('Get Battery Level'),
              onPressed: _getBatteryLevel,
            ),
            Text(batteryLevel),
          ],
        ),
      ),
    );
  }
}
