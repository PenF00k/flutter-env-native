import 'dart:async';

import 'package:env_native/env_native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
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
  Widget build(BuildContext context) => MaterialApp(
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
