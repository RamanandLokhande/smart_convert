class Validators {
  Validators._();

  static double? parseDouble(String? value) {
    if (value == null) return null;
    final v = value.replaceAll(',', '').trim();
    if (v.isEmpty) return null;
    return double.tryParse(v);
  }

  static bool isPositive(double? value) {
    return value != null && value > 0;
  }
}
