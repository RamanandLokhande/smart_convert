import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String get formattedTime {
    return DateFormat('HH:mm').format(this);
  }

  String get formattedDate {
    return DateFormat('MMM dd, yyyy').format(this);
  }

  String get formattedDateTime {
    return DateFormat('MMM dd, HH:mm').format(this);
  }
}

extension DoubleExt on double {
  String get formatted {
    return toStringAsFixed(2);
  }

  String get formattedCurrency {
    final formatter = NumberFormat.simpleCurrency();
    return formatter.format(this);
  }
}

extension StringExt on String {
  bool get isValidEmail {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(this);
  }

  bool get isValidNumber {
    return double.tryParse(this) != null;
  }
}
