import 'package:intl/intl.dart';
sealed class Helpers {
  static String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  return formatter.format(date);
}
}