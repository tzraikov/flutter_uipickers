import 'package:flutter/material.dart';
import 'package:uipickers/uipickers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int? selectedItem = 0;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(        
        body: Padding(
          padding: EdgeInsets.fromLTRB(100, 140, 20, 20),
          child: Column(
            children: [
              SizedBox(
                width: 150,
                height: 34,
                child: AdaptivePicker( 
                  //type: AdaptivePickerType.material,                 
                  items: [ 'red', 'green', 'blue', 'orange' ], 
                  value: selectedItem, 
                  onChanged: (val) { setState(() => selectedItem = val); }
                )
              ),
              SizedBox(height: 12),
              SizedBox(
                width: 150,
                height: 34,
                child: AdaptiveDatePicker(
                  //type: AdaptiveDatePickerType.material,
                  initialDate: selectedDate,
                  firstDate: DateTime.now(), 
                  lastDate: DateTime.now().add(Duration(days: 10)),
                  onChanged: (date) { setState(() => selectedDate = date); },
                )
              )
            ]
          )
        )
      )
    );
  }
}
