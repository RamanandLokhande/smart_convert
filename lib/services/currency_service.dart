import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CurrencyService {
  CurrencyService();

  static const String _baseUrl =
      "https://v6.exchangerate-api.com/v6/";

  // --------------------------------------------------
  // 🔹 Get Live Exchange Rate (PAIR ENDPOINT)
  // --------------------------------------------------

  Future<double> getExchangeRateInstance(
      String fromCurrency, String toCurrency) async {
    try {
      // Load API key safely
      final apiKey = dotenv.env['CURRENCY_API_KEY'];

      if (apiKey == null || apiKey.isEmpty) {
        throw Exception("API key not found in .env");
      }

      // Use PAIR endpoint (more stable for free plan)
      final url = Uri.parse(
          "$_baseUrl$apiKey/pair/$fromCurrency/$toCurrency");

      final response = await http
          .get(url)
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["result"] == "success") {
          final rate = data["conversion_rate"];

          if (rate == null) {
            throw Exception("Invalid conversion rate");
          }

          return (rate as num).toDouble();
        } else {
          throw Exception(
              "API Error: ${data["error-type"]}");
        }
      } else {
        throw Exception(
            "HTTP Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Exchange fetch failed: $e");
    }
  }

  // --------------------------------------------------
  // 🔹 Convert Amount
  // --------------------------------------------------

  Future<double> convertCurrency(
      String fromCurrency,
      String toCurrency,
      double amount) async {
    final rate =
        await getExchangeRateInstance(fromCurrency, toCurrency);

    return amount * rate;
  }

  // --------------------------------------------------
  // 🔹 Static Convenience Methods
  // --------------------------------------------------

  static Future<double> getExchangeRate(
      String from, String to) async {
    final service = CurrencyService();
    return service.getExchangeRateInstance(from, to);
  }

  static Future<double> convert(
      String from,
      String to,
      double amount) async {
    final service = CurrencyService();
    return service.convertCurrency(from, to, amount);
  }

  // --------------------------------------------------
  // 🔹 Supported Currency List
  // --------------------------------------------------

  List<String> getSupportedCurrencies() {
    return [
      'USD',
      'EUR',
      'INR',
      'GBP',
      'JPY',
      'AUD',
      'CAD',
    ];
  }

  // --------------------------------------------------
  // 🔹 Currency Symbols
  // --------------------------------------------------

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