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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 201, 95, 95), // background color
                borderRadius: BorderRadius.circular(12), // border radius
              ),
              child: WeeklyDatePicker(
                selectedDay: _selectedDay,
                changeDay: (value) {
                  setState(() {
                    _selectedDay = value;
                  });
                   // Format the selected date
                  String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDay);
                  // Print the formatted date to the console
                  print('Selected Date: $value');
                },
                enableWeeknumberText: false,
                weeknumberColor: const Color(0xFF57AF87),
                weeknumberTextColor: Colors.white,
                backgroundColor: Colors.transparent, // Set background color to transparent to avoid conflict
                weekdayTextColor: Color.fromARGB(255, 0, 0, 0),
                digitsColor: Colors.white,
                selectedDigitBackgroundColor: const Color(0xFF57AF87),
                weekdays: const ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"],
                daysInWeek: 7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
