import 'package:uuid/uuid.dart';

const uuid = Uuid();

class CalculationHistory {
  final String id;
  final String type;
  final String title;
  final String value;
  final String? details;
  final DateTime timestamp;

  CalculationHistory({
    String? id,
    required this.type,
    required this.title,
    required this.value,
    this.details,
    DateTime? timestamp,
  })  : id = id ?? uuid.v4(),
        timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'value': value,
      'details': details,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory CalculationHistory.fromJson(Map<String, dynamic> json) {
    return CalculationHistory(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      value: json['value'],
      details: json['details'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
