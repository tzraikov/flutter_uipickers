import 'package:flutter/material.dart';
import 'package:uipickers/uipickers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedItem = 0;
  DateTime selectedDate = DateTime.now();
  final key1 = GlobalKey();
  final key2 = GlobalKey();
  final items = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Padding(
                padding: const EdgeInsets.fromLTRB(100, 140, 20, 20),
                child: Column(children: [
                  SizedBox(
                      width: 150,
                      height: 34,
                      child: AdaptivePicker(
                          key: key1,
                          type: AdaptivePickerType.adaptive,
                          items: items,
                          value: selectedItem,
                          dropDownItemTextColor: Colors.green,
                          textColor: Colors.red,
                          tintColor: Colors.pink,
                          fontSize: 24,
                          onChanged: (val) {
                            setState(() {
                              selectedItem = val ?? 0;
                              selectedDate = DateTime.now().add(Duration(days: selectedItem));
                            });
                          })),
                  const SizedBox(height: 12),
                  SizedBox(
                      width: 150,
                      height: 34,
                      child: AdaptiveDatePicker(
                        key: key2,
                        type: AdaptiveDatePickerType.adaptive,
                        textColor: Colors.red,
                        tintColor: Colors.pink,
                        fontSize: 24,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 10)),
                        onChanged: (date) {
                          setState(() {
                            selectedDate = date;
                            selectedItem = daysBetween(DateTime.now(), selectedDate);
                          });
                        },
                      ))
                ]))));
  }

  int daysBetween(DateTime from, DateTime to) {
    var fromD = DateTime(from.year, from.month, from.day);
    var toD = DateTime(to.year, to.month, to.day);
    return (toD.difference(fromD).inHours / 24).round();
  }
}
