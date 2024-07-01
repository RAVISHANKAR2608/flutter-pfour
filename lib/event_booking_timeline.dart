library event_booking_timeline;

/// Import necessary packages
import 'package:flutter/material.dart';
import 'package:pfour/error_codes.dart';
import 'package:pfour/exceptions/exception.dart';

/// Booking class to store the start and end time of the booking
class Booking {
  /// Start time of the booking
  final String startTime;

  /// End time of the booking
  final String endTime;

  /// Constructor
  Booking({required this.startTime, required this.endTime});
}

class EventBookingTimeline extends StatefulWidget {
  /// Constructor with optional current booking slot highlight feature
  EventBookingTimeline({
    super.key,
    required this.onTimeSelected,
    required this.startTime,
    required this.endTime,
    required this.numberOfSubdivision,
    required this.widthOfSegment,
    required this.widthOfTimeDivisionBar,
    required this.booked,
    required this.moveToFirstAvailableTime,
    required this.is12HourFormat,
    required this.availableColor,
    required this.bookedColor,
    required this.moveToNextPrevSlot,
    required this.onError,
    required this.onTimeLineEnd,
    required this.blockUntilCurrentTime,
    required this.durationToBlock,
    this.showCurrentBlockedSlot = false,
    this.currentBlockedColor = Colors.yellow,
    required this.selectedBarColor,
    required this.selectedTextColor,
    required this.textColor,
    required this.barColor,
    required this.addBuffer,
  });

  /// Callback function to get the selected time
  final Function(String time) onTimeSelected;

  /// Callback function to get the error - like if the next x hours are not available, etc
  final Function(dynamic error) onError;

  /// Callback function to get the end of the timeline - like if the timeline reaches the end of the day, etc
  final Function() onTimeLineEnd;

  /// Starting time of the timeline (24 Hour Format)
  final String startTime;

  /// Ending time of the timeline
  final String endTime;

  /// The number of subdivisions between the main divisions
  final int numberOfSubdivision;

  /// The width of each time segments
  final double widthOfSegment;

  /// The thickness of each division
  final double widthOfTimeDivisionBar;

  /// List of booked slots
  final List<Booking> booked;

  /// To move the timeline to the next available slot
  final bool moveToFirstAvailableTime;

  /// The time to be displayed on the timeline
  final bool is12HourFormat;

  /// Should the timeline skip the blocked slots
  final bool moveToNextPrevSlot;

  /// Whether the current blocked state should be shown or not.
  final bool showCurrentBlockedSlot;

  /// Color to indicate available slot
  final Color availableColor;

  /// Color to indicate booked slot
  final Color bookedColor;

  /// Color to indicate current blocked slot
  final Color currentBlockedColor;

  /// Duration to block
  final double durationToBlock;

  /// State to block the timeline until the current time
  final bool blockUntilCurrentTime;

  /// Color of the current selected bar
  final Color selectedBarColor;

  /// Color of the current selected text
  final Color selectedTextColor;

  /// Color of the text
  final Color textColor;

  /// Color of the bar
  final Color barColor;

  /// Buffer to add to the timeline (Buffer before and after the events booked, bufferTime depends on the number of subdivisions)
  final bool addBuffer;

  @override
  State<EventBookingTimeline> createState() => _EventBookingTimelineState();
}

class _EventBookingTimelineState extends State<EventBookingTimeline> {
  /// Scrollcontroller for the timeline to scroll programmatically. [FixedExtentScrollController] is used to scroll to the exact item.
  late FixedExtentScrollController scrollController =
      FixedExtentScrollController(
    initialItem: 0,
  );

  /// Colors for the timeline
  late Color bookedColor;
  late Color availableColor;
  late Color currentBlockedColor;

  // Colors of text and bar
  late Color selectedBarColor;
  late Color selectedTextColor;
  late Color textColor;
  late Color barColor;

  late List<Booking> booked;

  List<String> timeSegments = [];

  int currentIndex = 0;
  int prevIndex = -1;

  late int numberOfSubdivision;

  late double totalWidth;
  late double width;
  late double timeDivisionBarHeight;
  late bool is12HourFormat;

  double eventBarHeight = 8;

  @override
  void initState() {
    super.initState();

    // Adding buffer to each booked slots
    setState(() {
      booked = addBuffer(widget.booked);
    });

    // Initializing the timeline
    setState(() {
      width = widget.widthOfSegment;
      numberOfSubdivision = widget.numberOfSubdivision;
      totalWidth = (numberOfSubdivision + 1) * width;
      timeDivisionBarHeight = widget.widthOfTimeDivisionBar;
      timeSegments = getTimes();
      is12HourFormat = widget.is12HourFormat;

      bookedColor = widget.bookedColor;
      availableColor = widget.availableColor;
      currentBlockedColor = widget.currentBlockedColor;

      selectedBarColor = widget.selectedBarColor;
      selectedTextColor = widget.selectedTextColor;
      textColor = widget.textColor;
      barColor = widget.barColor;
    });

    if (widget.blockUntilCurrentTime) {
      blockUntilCurrentTime();
    }

    // Finding first available slot
    int firstAvailableSlot = widget.booked.isEmpty
        ? 0
        : widget.moveToFirstAvailableTime
            ? getNextAvailableTime(0, timeSegments.length)
            : 0;

    setState(() {
      currentIndex = firstAvailableSlot;
    });

    scrollController =
        FixedExtentScrollController(initialItem: firstAvailableSlot);
  }

  /// Blocking the timeline until the current time
  void blockUntilCurrentTime() {
    DateTime now = DateTime.now();
    // Round off to nearest hour according to the numberOfSubdivision
    int hour = now.hour;

    int minute = now.minute;

    int maxMinutes = 60;

    if ((minute).toInt() > (maxMinutes ~/ (numberOfSubdivision + 1))) {
      minute = 0;
      if (hour == 23) {
        hour = 0;
      } else {
        hour += 1;
      }
    } else {
      minute = 30;
    }

    String time =
        "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";

    // Checking if booking contains the time in between the start and current time
    List<Booking> bookingList = booked;

    if (bookingList.isNotEmpty) {
      bookingList = bookingList.map((e) {
        String startTime = e.startTime;
        String endTime = e.endTime;

        if (timeSegments.indexOf(startTime) < timeSegments.indexOf(time)) {
          startTime = time;
        }

        if (timeSegments.indexOf(endTime) > timeSegments.indexOf(time)) {
          endTime = time;
        }

        return Booking(startTime: startTime, endTime: e.endTime);
      }).toList();

      booked = bookingList;
    }
    // Adding to booking
    booked.add(Booking(startTime: timeSegments.first, endTime: time));
  }

  /// Getting the list of time segments.
  List<String> getTimes() {
    List<String> timeStrings = [];

    String startTime = widget.startTime;
    String endTime = widget.endTime;

    int totalTime = int.parse(endTime.split(":")[0]) -
        int.parse(startTime.split(":")[0]) +
        1;

    int totalDivision = (totalTime * (widget.numberOfSubdivision + 1)) -
        widget.numberOfSubdivision;

    for (int i = 0; i < totalDivision; i++) {
      String time = startTime;
      timeStrings.add(time);

      int hour = int.parse(time.split(":")[0]);
      int minute = int.parse(time.split(":")[1]);

      int newMinute = minute + 60 ~/ (numberOfSubdivision + 1);

      if (newMinute >= 60) {
        hour += 1;
        minute = newMinute - 60;
      } else {
        minute = newMinute;
      }

      startTime =
          "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
    }

    return timeStrings;
  }

  /// Generating the text time according to the format
  String generateTimeString(String time, bool is12HourFormat) {
    int hour = int.parse(time.split(":")[0]);
    int minute = int.parse(time.split(":")[1]);

    if (is12HourFormat) {
      String period = hour >= 12 ? 'PM' : 'AM';
      hour = hour % 12;
      if (hour == 0) hour = 12;
      return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
    } else {
      return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    }
  }

  /// Adding buffer to each booked slots
  List<Booking> addBuffer(List<Booking> bookedList) {
    List<Booking> updatedBooking = [];

    for (Booking booking in bookedList) {
      String startTime = booking.startTime;
      String endTime = booking.endTime;

      int startTimeIndex = timeSegments.indexOf(startTime);
      int endTimeIndex = timeSegments.indexOf(endTime);

      if (startTimeIndex != -1 && endTimeIndex != -1) {
        // Adding buffer
        int newStartTimeIndex =
            startTimeIndex - numberOfSubdivision < 0 ? 0 : startTimeIndex - 1;
        int newEndTimeIndex =
            endTimeIndex + numberOfSubdivision >= timeSegments.length - 1
                ? timeSegments.length - 1
                : endTimeIndex + 1;

        startTime = timeSegments[newStartTimeIndex];
        endTime = timeSegments[newEndTimeIndex];
      }

      updatedBooking.add(Booking(startTime: startTime, endTime: endTime));
    }

    return updatedBooking;
  }

  /// Getting the next available slot
  int getNextAvailableTime(int start, int end) {
    List<String> availableTimeSegments = [];

    for (int i = start; i < end; i++) {
      availableTimeSegments.add(timeSegments[i]);
    }

    for (int i = start; i < end; i++) {
      List<Booking> bookedTimes = booked;

      if (bookedTimes.isNotEmpty) {
        for (var element in bookedTimes) {
          // getting range of time between start and end time
          int startIndex = timeSegments.indexOf(element.startTime);
          int endIndex = timeSegments.indexOf(element.endTime);

          for (int j = startIndex; j < endIndex; j++) {
            availableTimeSegments.remove(timeSegments[j]);
          }
        }
      }
    }

    if (availableTimeSegments.isNotEmpty) {
      int firstAvailableSlot = timeSegments.indexOf(availableTimeSegments.first);
      return firstAvailableSlot;
    } else {
      return -1; // or handle the case when no available slot is found
    }
  }

  /// Getting the previous available slot
  int getPrevAvailableTime(int start, int end) {
    List<String> availableTimeSegments = [];

    for (int i = start; i > end; i--) {
      availableTimeSegments.add(timeSegments[i]);
    }

    for (int i = start; i > end; i--) {
      List<Booking> bookedTimes = booked;

      if (bookedTimes.isNotEmpty) {
        for (var element in bookedTimes) {
          // getting range of time between start and end time
          int startIndex = timeSegments.indexOf(element.startTime);
          int endIndex = timeSegments.indexOf(element.endTime);

          for (int j = startIndex; j < endIndex; j++) {
            availableTimeSegments.remove(timeSegments[j]);
          }
        }
      }
    }

    if (availableTimeSegments.isNotEmpty) {
      int firstAvailableSlot = timeSegments.indexOf(availableTimeSegments.first);
      return firstAvailableSlot;
    } else {
      return -1; // or handle the case when no available slot is found
    }
  }

  /// To be called on time selected
  void onTimeSelected(int index) {
    setState(() {
      currentIndex = index;
    });

    widget.onTimeSelected(timeSegments[index]);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: NotificationListener<ScrollEndNotification>(
        onNotification: (scrollEnd) {
          if (scrollEnd.metrics.pixels == 0) {
            widget.onTimeLineEnd();
          }
          return false;
        },
        child: ListWheelScrollView(
          controller: scrollController,
          itemExtent: widget.widthOfSegment,
          physics: const FixedExtentScrollPhysics(),
          children: List<Widget>.generate(
            timeSegments.length,
            (index) {
              String time = timeSegments[index];
              bool isSelected = index == currentIndex;

              Color barColor = booked.any((element) => element.startTime == time)
                  ? bookedColor
                  : availableColor;

              Color timeTextColor =
                  isSelected ? selectedTextColor : textColor;

              return GestureDetector(
                onTap: () {
                  onTimeSelected(index);
                },
                child: Column(
                  children: [
                    Container(
                      height: timeDivisionBarHeight,
                      color: barColor,
                    ),
                    Text(
                      generateTimeString(time, is12HourFormat),
                      style: TextStyle(
                        color: timeTextColor,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          onSelectedItemChanged: (index) {
            if (index >= 0 && index < timeSegments.length) {
              onTimeSelected(index);
            }
          },
        ),
      ),
    );
  }
}
