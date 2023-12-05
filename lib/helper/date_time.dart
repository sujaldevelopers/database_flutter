import 'package:intl/intl.dart';

String formatWithYear(DateTime date) {
  return DateFormat("dd/MM/yyyy").format(date);
}

String formatWithMMM(DateTime date) {
  return DateFormat("dd/MMM/yyyy").format(date);
}

String formateWithMMMM(DateTime date) {
  return DateFormat("dd/MMMM/yyyy").format(date);
}

String formatWithTime(DateTime date) {
  return DateFormat("dd MMM yyyy").format(date);
}