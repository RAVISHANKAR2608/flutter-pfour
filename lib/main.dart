import 'package:flutter/material.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weekly Date Picker Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Weekly Date Picker Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          WeeklyDatePicker(
            selectedDay: _selectedDay,
            changeDay: (value) {
              setState(() {
                _selectedDay = value;
              });
               // Format the selected date
              String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDay);
              // Print the formatted date to the console
              print('Selected Date: $formattedDate');
            },
            enableWeeknumberText: false,
            weeknumberColor: const Color(0xFF57AF87),
            weeknumberTextColor: Colors.white,
            backgroundColor: const Color(0xFF1A1A1A),
            weekdayTextColor: const Color(0xFF8A8A8A),
            digitsColor: Colors.white,
            selectedDigitBackgroundColor: const Color(0xFF57AF87),
            weekdays: const ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"],
            daysInWeek: 7,
          ),
        ],
      ),
    );
  }
}