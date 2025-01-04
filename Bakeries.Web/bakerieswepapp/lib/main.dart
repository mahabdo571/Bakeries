import 'package:bakerieswepapp/Screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'dart:io'; 

void main() {
  HttpOverrides.global = MyHttpOverrides();

  runApp(MaterialApp( 
    debugShowCheckedModeBanner: false,
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


