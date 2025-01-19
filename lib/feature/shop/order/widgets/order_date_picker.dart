import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class SelectDate extends StatelessWidget {
  const SelectDate(
      {super.key,
      required this.title,
      required this.controller,
      this.validator});

  final String title;
  final TextEditingController controller;

  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        decoration: InputDecoration(
            labelText: title, prefixIcon: const Icon(Iconsax.calendar)),
        readOnly: true,
        onTap: () => selectDate(context: context),
        validator: validator);
  }

  selectDate({required BuildContext context}) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime(2100),
      firstDate: today,
      initialDate: today,
    );
    if (pickedDate == null) return;
    controller.text = DateFormat('MM-dd-yyyy').format(pickedDate);
  }
}

class SelectTime extends StatelessWidget {
  const SelectTime(
      {super.key,
      required this.title,
      required this.controller,
      this.validator});

  final String title;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        decoration: InputDecoration(
            labelText: title, prefixIcon: const Icon(Iconsax.clock)),
        readOnly: true,
        onTap: () => selectTime(context: context),
        validator: validator);
  }

  selectTime({required BuildContext context}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime == null) return;
    final now = DateTime.now();
    final pickedDateTime = DateTime(now.year, now.month, now.day,
        pickedTime.hour, pickedTime.minute);

    // Format the picked time in "HH:mm" format
    controller.text = DateFormat('hh:mm a').format(pickedDateTime);
  }

  
}
