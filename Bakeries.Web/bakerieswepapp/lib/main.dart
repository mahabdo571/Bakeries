import 'package:bakerieswepapp/Screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'dart:io'; // ضروري لاستخدام HttpOverrides

void main() {
  // تعطيل التحقق من الشهادات
  HttpOverrides.global = MyHttpOverrides();

  // تشغيل التطبيق بعد تعطيل التحقق من الشهادات
  runApp(MaterialApp(
    home: Scaffold(
      body: HomePage(),
    ),
  ));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}


