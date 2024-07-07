import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class TimelineWidget extends StatefulWidget {
  final DateTime currentTime;
  final List<TimeRange> bookedTimes;

  const TimelineWidget({
    Key? key,
    required this.currentTime,
    required this.bookedTimes,
  }) : super(key: key);

  @override
  _TimelineWidgetState createState() => _TimelineWidgetState();
}

class _TimelineWidgetState extends State<TimelineWidget> {
  late ScrollController _scrollController;
  final double intervalWidth = 15;
  final double paddingWidth = 200; // Adjust the padding width as needed

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _centerCurrentTime();
    });
  }

  void _centerCurrentTime() {
  int currentHour = widget.currentTime.hour - 10; // Start from 10 AM
  int currentMinute = widget.currentTime.minute;
  int currentInterval = currentHour * 12 + (currentMinute / 5).round();
  double targetPosition = currentInterval * intervalWidth +
      paddingWidth -
      MediaQuery.of(context).size.width / 2 +
      intervalWidth / 2;

  // Ensure we do not scroll to a negative position
  if (targetPosition < 0) {
    targetPosition = 0;
  }

  // Ensure we do not scroll beyond the maximum position
  double maxPosition = (144 * intervalWidth) + (2 * paddingWidth) - MediaQuery.of(context).size.width;
  if (targetPosition > maxPosition) {
    targetPosition = maxPosition;
  }

  _scrollController.jumpTo(targetPosition);
}


  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: timelineMargin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.arrow_downward),
          const SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount:
                  145 + 2,// 12 hours * 12 intervals per hour (5 minutes each) + 2 for padding
              itemBuilder: (context, index) {
                if (index == 0 || index == 146) {
                  // Add padding at the start and end
                  return SizedBox(width: paddingWidth);
                }

                DateTime intervalTime = DateTime(
                  widget.currentTime.year,
                  widget.currentTime.month,
                  widget.currentTime.day,
                  10,
                  0,
                ).add(Duration(minutes: 5 * (index - 1)));
                return Container(
                  width: intervalWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomPaint(
                        painter: IntervalPainter(
                          currentTime: widget.currentTime,
                          intervalTime: intervalTime,
                          bookedTimes: widget.bookedTimes,
                        ),
                        child: Container(
                          height: 30,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class IntervalPainter extends CustomPainter {
  final DateTime currentTime;
  final DateTime intervalTime;
  final List<TimeRange> bookedTimes;

  IntervalPainter({
    required this.currentTime,
    required this.intervalTime,
    required this.bookedTimes,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..strokeWidth = 4;

    // Set color based on the interval time
    if (intervalTime.isBefore(currentTime)) {
      paint.color = Colors.purple; // Past time interval color
    } else if (bookedTimes.any((range) => range.overlaps(
        intervalTime, intervalTime.add(const Duration(minutes: 5))))) {
      paint.color = Colors.red; // Booked time interval color
    } else {
      paint.color = Colors.green; // Available time interval color
    }

    // Draw the interval line
    canvas.drawLine(
        Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);

    // Draw the small lines at the bottom for each hour
    if (intervalTime.minute == 0) {
      paint.color = Colors.black;
      paint.strokeWidth = 3;
      canvas.drawLine(
          Offset(0, size.height / 2 + 10), const Offset(0, 55), paint);
    } else if (intervalTime.minute == 30) {
      paint.color = Colors.black;
      paint.strokeWidth = 2;
      canvas.drawLine(
          Offset(0, size.height / 2 + 10), const Offset(0, 45), paint);
    } else if (intervalTime.minute == 15 || intervalTime.minute == 45) {
      paint.color = Colors.black;
      paint.strokeWidth = 2;
      canvas.drawLine(
          Offset(0, size.height / 2 + 10), const Offset(0, 35), paint);
    } else if (intervalTime.minute == 5 ||
        intervalTime.minute == 10 ||
        intervalTime.minute == 20 ||
        intervalTime.minute == 25 ||
        intervalTime.minute == 35 ||
        intervalTime.minute == 40 ||
        intervalTime.minute == 50 ||
        intervalTime.minute == 55) {
      paint.color = Colors.black;
      paint.strokeWidth = 2;
      canvas.drawLine(Offset(0, size.height / 2 + 10), const Offset(0, 30), paint);
    }

    // Draw the hour text
    if (intervalTime.minute == 0) {
      String timeText = DateFormat('hh:mm').format(intervalTime);
      String hour = DateFormat('h').format(intervalTime);
      String period = DateFormat('a').format(intervalTime);

      TextSpan span = TextSpan(
        children: [
          TextSpan(
            text: timeText,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 12.0,
                fontWeight: FontWeight.w800),
          ),
          TextSpan(
            text: "\n$period",
            style: const TextStyle(color: Colors.black, fontSize: 12.0),
          ),
        ],
      );

      TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: ui.TextDirection.ltr,
      );
      tp.layout();

      // Calculate the position
      double xPos =
          -tp.width / 2; // Center horizontally below the vertical line
      double yPos =
          size.height / 2 + 50; // Adjust the vertical position as needed

      tp.paint(canvas, Offset(xPos, yPos));
    }
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
        title: const Text('Horizontal Timeline Example'),
      ),
      body: Center(
        child: TimelineWidget(
          // currentTime: DateTime.now(),
          currentTime: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 10, 30),
          bookedTimes: [
            TimeRange(
              DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 21, 0),
              DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 22, 0),
            ), // Example booked interval
            TimeRange(
              DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 19, 0),
              DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 20, 0),
            ), // Example booked interval
          ],
        ),
      ),
    ),
  ));
}
