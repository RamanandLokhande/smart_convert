import 'dart:async';

class CurrencyService {
  CurrencyService();

  // Mock exchange rates relative to USD
  static final Map<String, double> _mockBase = {
    'USD': 1.0,
    'EUR': 0.92,
    'INR': 82.0,
    'GBP': 0.79,
    'JPY': 148.0,
    'AUD': 1.5,
    'CAD': 1.35,
  };

  // Static convenience method (API-ready)
  static Future<double> getExchangeRate(String from, String to) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final fromRate = _mockBase[from] ?? 1.0;
    final toRate = _mockBase[to] ?? 1.0;
    return toRate / fromRate;
  }

  static Future<double> convert(String from, String to, double amount) async {
    final rate = await getExchangeRate(from, to);
    return amount * rate;
  }

  // Instance methods used by legacy UI
  Future<double> convertCurrency(String fromCurrency, String toCurrency, double amount) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final from = _mockBase[fromCurrency] ?? 1.0;
    final to = _mockBase[toCurrency] ?? 1.0;
    return (amount / from) * to;
  }

  Future<double> getExchangeRateInstance(String fromCurrency, String toCurrency) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final from = _mockBase[fromCurrency] ?? 1.0;
    final to = _mockBase[toCurrency] ?? 1.0;
    return to / from;
  }

  List<String> getSupportedCurrencies() {
    return _mockBase.keys.toList()..sort();
  }

  String getCurrencySymbol(String currency) {
    const symbols = {
      'USD': '\$',
      'EUR': '€',
      'GBP': '£',
      'JPY': '¥',
      'AUD': '\$',
      'CAD': '\$',
      'INR': '₹',
    };
    return symbols[currency] ?? currency;
  }
}

