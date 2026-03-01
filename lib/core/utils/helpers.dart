import 'package:intl/intl.dart';

class AppHelpers {
  /// Format currency value with currency code
  static String formatCurrency(double amount, String currencyCode) {
    try {
      final formatter = NumberFormat.currency(
        symbol: currencyCode,
        decimalDigits: 2,
      );
      return formatter.format(amount);
    } catch (e) {
      return '$currencyCode ${amount.toStringAsFixed(2)}';
    }
  }

  /// Format date to readable format
  static String formatDate(DateTime dateTime) {
    return DateFormat('MMM dd, yyyy hh:mm a').format(dateTime);
  }

  /// Format date to short format
  static String formatDateShort(DateTime dateTime) {
    return DateFormat('MMM dd, yyyy').format(dateTime);
  }

  /// Format time only
  static String formatTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  /// Validate email
  static bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Validate number
  static bool isValidNumber(String value) {
    try {
      double.parse(value);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Calculate age from birth date
  static int calculateAge(DateTime birthDate) {
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  /// Get BMI category based on BMI value
  static String getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 25) {
      return 'Normal Weight';
    } else if (bmi >= 25 && bmi < 30) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  /// Get color based on value
  static String getColorCategory(double value) {
    if (value < 0) {
      return 'red';
    } else if (value == 0) {
      return 'grey';
    } else {
      return 'green';
    }
  }
}
