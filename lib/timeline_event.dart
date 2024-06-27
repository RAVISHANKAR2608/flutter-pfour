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
          Container(
            height: 20,
            width: 2,
            color: selected ? Colors.blue : Colors.grey,
          ),
          const SizedBox(height: 8.0),
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
