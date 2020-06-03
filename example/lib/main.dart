import 'dart:async';

import 'package:env_native/env_native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _message = 'Loading...';

  @override
  void initState() {
    super.initState();
    getMessage();
  }

  Future<void> getMessage() async {
    String message;
    try {
      final s = await EnvNative.getString('test_string');
      final i = await EnvNative.getInt('test_int');
      message = '$s, $i';
    } on PlatformException catch (e) {
      message = 'Failed to get variables: $e';
    }

    if (!mounted) return;

    setState(() {
      _message = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text(_message),
        ),
      ),
    );
  }
}
