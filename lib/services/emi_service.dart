import 'dart:math' as math;

class EmiService {
  EmiService._();

  // P = principal, annualRate in percent, months N
  static double calculateEmi({required double principal, required double annualRate, required int months}) {
    final monthlyRate = annualRate / 12 / 100;
    if (monthlyRate == 0) return principal / months;
    final r = monthlyRate;
    final n = months;
    final factor = math.pow(1 + r, n).toDouble();
    final numerator = principal * r * factor;
    final denominator = factor - 1;
    return numerator / denominator;
  }
}
