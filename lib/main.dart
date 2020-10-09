import 'package:energia_perosnalapp_sql/ShowList.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Energia_personnel app',
      home: ShowList(),
    );
  }
}
