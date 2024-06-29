import 'package:flutter/material.dart';

class TimelineWidget extends StatelessWidget {
  final DateTime currentTime; // Current time
  final List<TimeRange> bookedTimes; // List of booked time intervals

  TimelineWidget({
    required this.currentTime,
    required this.bookedTimes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.arrow_downward), // Down arrow
        SizedBox(height: 10),
        // Horizontal timeline for hours
        Container(
          height: 100, // Height of the timeline
          width: double.infinity, // Width to fill the available space
          child: CustomPaint(
            painter: HorizontalTimelinePainter(
              currentTime: currentTime,
              bookedTimes: bookedTimes,
            ),
          ),
        ),
      ],
    );
  }
}

class HorizontalTimelinePainter extends CustomPainter {
  final DateTime currentTime;
  final List<TimeRange> bookedTimes;

  HorizontalTimelinePainter({
    required this.currentTime,
    required this.bookedTimes,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double hourWidth = size.width / 12; // Each hour takes 1/12th of the width

    final paint = Paint()
      ..strokeWidth = 10;

    // Draw the timeline intervals with colors based on conditions
    for (int i = 0; i < 12; i++) {
      DateTime hourStartTime = DateTime(currentTime.year, currentTime.month, currentTime.day, 10 + i);
      DateTime hourEndTime = hourStartTime.add(Duration(hours: 1));

      if (hourEndTime.isBefore(currentTime)) {
        paint.color = Colors.purple; // Past time interval color
      } else if (bookedTimes.any((range) => range.overlaps(hourStartTime, hourEndTime))) {
        paint.color = Colors.red; // Booked time interval color
      } else {
        paint.color = Colors.green; // Available time interval color
      }

      double startX = i * hourWidth;
      canvas.drawLine(Offset(startX, size.height / 2), Offset(startX + hourWidth, size.height / 2), paint);
    }

    // Draw the current time indicator
    // paint.color = Colors.blue;
    // double currentX = ((currentTime.hour - 10) + currentTime.minute / 60) * hourWidth;
    // canvas.drawLine(Offset(currentX, 0), Offset(currentX, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class TimeRange {
  final DateTime start;
  final DateTime end;

  TimeRange(this.start, this.end);

  bool overlaps(DateTime startTime, DateTime endTime) {
    return start.isBefore(endTime) && end.isAfter(startTime);
  }
}

// Example usage:
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Horizontal Timeline Example'),
      ),
      body: Center(
        child: TimelineWidget(
          currentTime: DateTime.now(),
          bookedTimes: [
            TimeRange(
              DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 16, 5),
              DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 17, 5),
            ), // Example booked interval
            TimeRange(
              DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 18, 0),
              DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 19, 0),
            ), // Example booked interval
          ],
        ),
      ),
    ),
  ));
}
