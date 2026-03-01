class AppConstants {
  AppConstants._();

  static const List<String> currencies = [
    'USD',
    'EUR',
    'INR',
    'GBP',
    'JPY',
  ];

  static const Map<String, List<String>> unitCategories = {
    'Length': ['Meter', 'Kilometer', 'Mile', 'Feet'],
    'Weight': ['Kilogram', 'Gram', 'Pound'],
    'Temperature': ['Celsius', 'Fahrenheit'],
    'Area': ['Square Meter', 'Square Foot'],
    'Speed': ['Km/h', 'Mph'],
    'Data': ['MB', 'GB'],
  };
}

