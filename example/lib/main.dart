import 'package:flutter/material.dart';
import 'package:web_date_picker/web_date_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode()); //remove focus
        },
        child: Scaffold(
          body: Center(
            child: WebDatePicker(
              onChange: (value) {
              },
            ),
          ),
        ),
      ),
    );
  }
}