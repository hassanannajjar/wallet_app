import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wallet_app/transaction.dart';
import 'package:flutter_riverpod/src/framework.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet App',
      debugShowCheckedModeBanner: false,
      home: TransactionScreen(),
    );
  }
}

// **** MediaQuery ****
double pixelRatio = window.devicePixelRatio;

// ----------------------------------------

/// Size in physical pixels
Size physicalScreenSize = window.physicalSize;
double physicalWidth = physicalScreenSize.width;
double physicalHeight = physicalScreenSize.height;

/// Size in logical pixels
Size logicalScreenSize = window.physicalSize / pixelRatio;

///  ignore: duplicate_ignore
double DEVICE_WIDTH = logicalScreenSize.width;
double DEVICE_HEIGHT = logicalScreenSize.height;
