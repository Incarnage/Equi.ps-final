import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class TimePicker extends StatefulWidget {
  final Function(String time) onTimeSelected;

  const TimePicker({Key? key, required this.onTimeSelected}) : super(key: key);


  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  var hour = 1;
  var minute = 0;
  var timeFormat = "AM";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Pick Your Time! ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $timeFormat",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Hour Picker
                NumberPicker(
                  minValue: 1,
                  maxValue: 12,
                  value: hour,
                  onChanged: (value) => setState(() => hour = value),
                  zeroPad: true,
                ),
                // Minute Picker
                NumberPicker(
                  minValue: 0,
                  maxValue: 59,
                  value: minute,
                  onChanged: (value) => setState(() => minute = value),
                  zeroPad: true,
                ),
                // AM/PM Selector
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => timeFormat = "AM"),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: timeFormat == "AM"
                              ? Colors.grey.shade800
                              : Colors.grey.shade700,
                        ),
                        child: const Text("AM", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => setState(() => timeFormat = "PM"),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: timeFormat == "PM"
                              ? Colors.grey.shade800
                              : Colors.grey.shade700,
                        ),
                        child: const Text("PM", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final selectedTime =
                    "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $timeFormat";
                widget.onTimeSelected(selectedTime);
                Navigator.pop(context);
              },
              child: const Text("Confirm Time"),
            ),
          ],
        ),
      ),
    );
  }
}
