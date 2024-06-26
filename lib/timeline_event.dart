import 'package:flutter/material.dart';

class TimeSlot extends StatelessWidget {
  final String time;
  final bool selected;
  final bool booked;
  final VoidCallback onTap;

  TimeSlot({
    required this.time,
    required this.selected,
    required this.booked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50.0),
          Container(
            height: 20,
            width: 2,
            color: booked ? Colors.red : Colors.green,
          ),
          Text(
            time,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selected ? Colors.blue : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
