import 'package:intl/intl.dart';

final class Conversion {
  static String formatDate(DateTime dateTime) {
    final format = DateFormat("d MMMM, yyyy", "en_US");
    String formattedDate = format.format(dateTime);

    final day = dateTime.day;
    final ordinalSuffix = _getOrdinalSuffix(day);
    formattedDate = formattedDate.replaceFirstMapped(
      RegExp(r'\b\d{1,2}\b'),
      (match) => '${match.group(0)}$ordinalSuffix',
    );

    return formattedDate;
  }

  static String _getOrdinalSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }

    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
