class MetalService {
  MetalService();

  // Mocked prices (USD per ounce) to avoid external http dependency.
  static final Map<String, double> _mockPrices = {
    'gold': 1900.0,
    'silver': 23.0,
  };

  static const double goldToSilverRatio = 80.0;

  /// Simulate fetching current gold price in USD per ounce
  Future<double> getGoldPrice() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockPrices['gold']!;
  }

  /// Simulate fetching current silver price in USD per ounce
  Future<double> getSilverPrice() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockPrices['silver']!;
  }

  /// Convert gold grams to silver grams (1:80 ratio)
  double convertGoldToSilver(double goldGrams) {
    return goldGrams * goldToSilverRatio;
  }

  /// Calculate total value of gold
  static double calculateGoldValue(double weight, double pricePerOunce) {
    // Convert grams to ounces (1 ounce = 28.3495 grams)
    final weightInOunces = weight / 28.3495;
    return weightInOunces * pricePerOunce;
  }

  /// Format price as currency
  static String formatPrice(double price) {
    return '\$${price.toStringAsFixed(2)}';
  }
}
