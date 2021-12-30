import 'package:flutter/material.dart';
import 'TestNotifyScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TestNotifyScreen(),
    );
  }
}

