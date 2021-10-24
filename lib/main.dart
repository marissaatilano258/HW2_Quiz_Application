import 'package:flutter/material.dart';
import 'router.dart' as router;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: router.generateRoute,
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}
