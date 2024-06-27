import 'package:flutter/material.dart';
import 'timeline_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horizontal Timeline Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HorizontalTimeline(),
    );
  }
}

class HorizontalTimeline extends StatefulWidget {
  const HorizontalTimeline({super.key});

  @override
  State<HorizontalTimeline> createState() => _HorizontalTimelineState();
}

class _HorizontalTimelineState extends State<HorizontalTimeline> {
  int? selectedIndex;

  // List of booked slots
  final List<String> bookedSlots = ['2:00 PM', '3:00 PM'];

  List<String> generateTimeSlots() {
    List<String> timeSlots = [];
    int startHour = 10; // 10:00 AM
    int endHour = 21; // 9:00 PM
    for (int hour = startHour; hour <= endHour; hour++) {
      String period = hour < 12 ? 'AM' : 'PM';
      int displayHour = hour % 12;
      if (displayHour == 0) displayHour = 12;
      timeSlots.add('${displayHour}:00 $period');
    }
    return timeSlots;
  }

  @override
  Widget build(BuildContext context) {
    List<String> timeSlots = generateTimeSlots();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horizontal Timeline'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 2,
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                children: timeSlots.map((time) {
                  return Expanded(
                    child: Container(
                      color: bookedSlots.contains(time) ? Colors.red : Colors.green,
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: timeSlots.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TimeSlot(
                      time: timeSlots[index],
                      selected: selectedIndex == index,
                      booked: bookedSlots.contains(timeSlots[index]),
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            if (selectedIndex != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Selected Time: ${timeSlots[selectedIndex!]}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
