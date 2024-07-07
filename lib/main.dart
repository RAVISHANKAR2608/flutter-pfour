import 'package:flutter/material.dart';
import 'package:pfour/timeline_wiget.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: TimelineWidget(
          currentTime: DateTime.now(),
          bookedTimes: [
            TimeRange(
              DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 14, 0),
              DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 15, 0),
            ),
            TimeRange(
              DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 16, 0),
              DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 17, 0),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyHomePage(),
  ));
}
