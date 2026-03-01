class GstService {
  GstService._();

  static double addGst({required double amount, required double gstPercent}) {
    final factor = 1 + gstPercent / 100;
    return amount * factor;
  }

  static double removeGst({required double amountWithGst, required double gstPercent}) {
    final factor = 1 + gstPercent / 100;
    if (factor == 0) return amountWithGst;
    return amountWithGst / factor;
  }
}
