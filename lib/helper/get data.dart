import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<DateTime?> getdata({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  final DateTime? date = await showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: firstDate ?? DateTime.now().subtract(Duration(days: 30)),
    lastDate: lastDate ?? DateTime.now().add(Duration(days: 365)),
    confirmText: "Save",
    helpText: "Select Completion Date",
  );
  return date;
}
