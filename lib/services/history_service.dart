import '../models/calculation_history.dart';

class HistoryService {
  static final HistoryService _instance = HistoryService._internal();
  final List<CalculationHistory> _history = [];

  factory HistoryService() {
    return _instance;
  }

  HistoryService._internal();

  List<CalculationHistory> get history => _history;

  void addCalculation(CalculationHistory calculation) {
    _history.insert(0, calculation);
  }

  void removeCalculation(String id) {
    _history.removeWhere((item) => item.id == id);
  }

  void clearHistory() {
    _history.clear();
  }

  List<CalculationHistory> getCalculationsByType(String type) {
    return _history.where((item) => item.type == type).toList();
  }
}
