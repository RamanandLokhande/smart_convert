class UnitService {
  UnitService._();

  static final Map<String, Map<String, double>> _length = {
    'Meter': {'Meter': 1, 'Kilometer': 0.001, 'Mile': 0.000621371, 'Feet': 3.28084},
    'Kilometer': {'Meter': 1000, 'Kilometer': 1, 'Mile': 0.621371, 'Feet': 3280.84},
    'Mile': {'Meter': 1609.34, 'Kilometer': 1.60934, 'Mile': 1, 'Feet': 5280},
    'Feet': {'Meter': 0.3048, 'Kilometer': 0.0003048, 'Mile': 0.000189394, 'Feet': 1},
  };

  static final Map<String, Map<String, double>> _weight = {
    'Kilogram': {'Kilogram': 1, 'Gram': 1000, 'Pound': 2.20462},
    'Gram': {'Kilogram': 0.001, 'Gram': 1, 'Pound': 0.00220462},
    'Pound': {'Kilogram': 0.453592, 'Gram': 453.592, 'Pound': 1},
  };

  static final Map<String, Map<String, double>> _area = {
    'Square Meter': {'Square Meter': 1, 'Square Foot': 10.7639},
    'Square Foot': {'Square Meter': 0.092903, 'Square Foot': 1},
  };

  static final Map<String, Map<String, double>> _speed = {
    'Km/h': {'Km/h': 1, 'Mph': 0.621371},
    'Mph': {'Km/h': 1.60934, 'Mph': 1},
  };

  static final Map<String, Map<String, double>> _data = {
    'MB': {'MB': 1, 'GB': 0.001},
    'GB': {'MB': 1000, 'GB': 1},
  };

  static double convert({
    required String category,
    required String from,
    required String to,
    required double value,
  }) {
    if (category == 'Length') {
      return _convertWithMap(_length, from, to, value);
    } else if (category == 'Weight') {
      return _convertWithMap(_weight, from, to, value);
    } else if (category == 'Temperature') {
      return _convertTemperature(from, to, value);
    } else if (category == 'Area') {
      return _convertWithMap(_area, from, to, value);
    } else if (category == 'Speed') {
      return _convertWithMap(_speed, from, to, value);
    } else if (category == 'Data') {
      return _convertWithMap(_data, from, to, value);
    }

    return value;
  }

  static double _convertWithMap(Map<String, Map<String, double>> map, String from, String to, double value) {
    final fromMap = map[from];
    if (fromMap == null) return value;
    final factor = fromMap[to];
    if (factor == null) return value;
    return value * factor;
  }

  static double _convertTemperature(String from, String to, double value) {
    if (from == to) return value;
    if (from == 'Celsius' && to == 'Fahrenheit') {
      return value * 9 / 5 + 32;
    } else if (from == 'Fahrenheit' && to == 'Celsius') {
      return (value - 32) * 5 / 9;
    }
    return value;
  }
}
