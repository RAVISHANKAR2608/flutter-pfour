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
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 2,
                  color: Colors.grey,
                ),
              ),
            ),
            ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: timeSlots.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TimeSlot(
                    time: timeSlots[index],
                    selected: selectedIndex == index,
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                );
              },
            ),
            if (selectedIndex != null)
              Positioned(
                bottom: 16.0,
                left: MediaQuery.of(context).size.width / 2 - 75,
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
