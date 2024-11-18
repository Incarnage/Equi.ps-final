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
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime(2100),
      firstDate: DateTime(2024),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    controller.text = DateFormat('MM-dd-yyyy').format(pickedDate);
  }
}
