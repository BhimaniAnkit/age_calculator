import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Age Calculator",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: AgeCalculatorApp(),
    );
  }
}

class AgeCalculatorApp extends StatefulWidget {
  const AgeCalculatorApp({Key? key}) : super(key: key);

  @override
  State<AgeCalculatorApp> createState() => _AgeCalculatorAppState();
}

class _AgeCalculatorAppState extends State<AgeCalculatorApp> {
  final dateController = TextEditingController();
  String age = "0";

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  String calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;

    if (month2 > month1) {
      age--;
    }
    else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Age Calculator"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              TextField(
                readOnly: true,
                controller: dateController,
                decoration: InputDecoration(hintText: "Pick Your Date"),
                onTap: () async {
                  var date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100)
                  );
                  if(date != null){
                    setState(() {
                      age = calculateAge(date);
                    });
                    dateController.text = DateFormat('dd/MM/yyyy').format(date);
                  }
                },
              ),
              // Container(
              //   height: 50,
              //   width: 200,
                // decoration: InputDecoration(
                //   border: GradientOutlineInputBorder(
                //       gradient: LinearGradient(
                //         colors: [Colors.orange,Colors.pink,Colors.purpleAccent],
                //       ),
                //       width: 3.0,
                //   ),
                // ),
              // ),
              Text("You are $age years old!",
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 25,decorationThickness: 5.0,decorationStyle: TextDecorationStyle.dashed,
                      color: HexColor("ee82ee"),
                      fontWeight: FontWeight.bold,
                      decorationColor: HexColor("ee82ee")
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
