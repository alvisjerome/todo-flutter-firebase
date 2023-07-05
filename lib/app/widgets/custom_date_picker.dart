import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  const CustomDatePicker({super.key, required this.onDateSelected});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  final currentDate = DateTime.now();
  final lastDate = DateTime(2100);

  Future<void> handleSelectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: handleSelectDate,
      child: const Icon(Icons.add),
    );
  }
}
