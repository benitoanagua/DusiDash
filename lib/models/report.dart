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

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      status: json['status'],
      generatedBy: User.fromJson(json['generatedBy']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      data: Map<String, dynamic>.from(json['data']),
      metrics: Map<String, dynamic>.from(json['metrics']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'status': status,
      'generatedBy': generatedBy.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'data': data,
      'metrics': metrics,
    };
  }
}
