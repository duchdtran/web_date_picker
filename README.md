# web_date_picker 

The [Web date picker](https://pub.dev/packages/web_date_picker) provides a date picker rendering library for web application development.

Based on [React date picker](https://www.npmjs.com/package/react-datepicker). 

## Installation

In the `dependencies:` section of your `pubspec.yaml`, add the following line:

```yaml
dependencies:
  web_date_picker: <latest_version>
```

## Usage

```dart
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
          FocusScope.of(context).requestFocus(FocusNode());
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
```