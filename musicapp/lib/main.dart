import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:musicapp/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Beats',
        theme: ThemeData(
            fontFamily: "champ",
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent, elevation: 0.0)),
        home: const MyHome());
  }
}
