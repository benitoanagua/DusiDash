import 'user.dart';

class Report {
  final String id;
  final String title;
  final String type;
  final String status;
  final User generatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic> data;
  final Map<String, dynamic> metrics;

  Report({
    required this.id,
    required this.title,
    required this.type,
    required this.status,
    required this.generatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.data,
    required this.metrics,
  });
}
