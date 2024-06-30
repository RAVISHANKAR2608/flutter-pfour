import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimelineWidget extends StatefulWidget {
  final DateTime currentTime;
  final List<TimeRange> bookedTimes;

  const TimelineWidget({
    required this.currentTime,
    required this.bookedTimes,
  });

  @override
  _TimelineWidgetState createState() => _TimelineWidgetState();
}

class _TimelineWidgetState extends State<TimelineWidget> {
  late ScrollController _scrollController;
  final double intervalWidth = 15;
  final double timelineMargin = 20;

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
    double targetPosition = currentInterval * intervalWidth -
        MediaQuery.of(context).size.width / 2 +
        intervalWidth / 2;

    _scrollController.jumpTo(targetPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: timelineMargin),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.arrow_downward),
          const SizedBox(height: 10),
          SizedBox(
            height: 80, // Increased height to provide enough vertical space
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount:
                  145, // 12 hours * 12 intervals per hour (5 minutes each) + 1 extra for 10 PM
              itemBuilder: (context, index) {
                DateTime intervalTime = DateTime(
                  widget.currentTime.year,
                  widget.currentTime.month,
                  widget.currentTime.day,
                  10,
                  0,
                ).add(Duration(minutes: 5 * index));
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
                          height: 30, // Height of the interval line container
                        ),
                      ),
                      const SizedBox(
                          height: 20), // Space between lines and time texts
                      if (intervalTime.minute == 0 ||
                          (intervalTime.hour == 22 &&
                              intervalTime.minute ==
                                  0)) // Add condition to show 10 PM
                        Column(
                          children: [
                            Text(
                              DateFormat('h').format(
                                  intervalTime), // Show hour in 12-hour format
                              style: const TextStyle(fontSize: 8),
                            ),
                            Text(
                              DateFormat('a')
                                  .format(intervalTime), // Show AM/PM
                              style: const TextStyle(fontSize: 8),
                            ),
                          ],
                        ),
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
    final paint = Paint()..strokeWidth = 2;

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

    // Draw dots at the start of each hour and at 10:00 PM
    if (intervalTime.minute == 0 ||
        (intervalTime.hour == 22 && intervalTime.minute == 0)) {
      paint.style = PaintingStyle.fill;
      canvas.drawCircle(Offset(size.width / 2, size.height / 2), 4, paint);
    }

    // Draw the small lines at the bottom for each hour
    if (intervalTime.minute == 0) {
      paint.color = Colors.black;
      paint.strokeWidth = 2;
      canvas.drawLine(Offset(size.width / 2, size.height / 2 + 10),
          Offset(size.width / 2, 45), paint);
    } else if (intervalTime.minute == 30) {
      paint.color = Colors.black;
      paint.strokeWidth = 2;
      canvas.drawLine(Offset(size.width / 2, size.height / 2 + 10),
          Offset(size.width / 2, 35), paint);
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
          currentTime: DateTime.now(),
          bookedTimes: [
            TimeRange(
              DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 19, 45),
              DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 21, 0),
            ), // Example booked interval
            TimeRange(
              DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 18, 15),
              DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 19, 15),
            ), // Example booked interval
          ],
        ),
      ),
    ),
  ));
}
