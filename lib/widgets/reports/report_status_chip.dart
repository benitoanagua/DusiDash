import 'package:fluent_ui/fluent_ui.dart';

class ReportStatusChip extends StatelessWidget {
  final String status;

  const ReportStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final statusConfig = {
      'completed': {'color': Colors.green, 'label': 'Completed'},
      'in_progress': {'color': Colors.blue, 'label': 'In Progress'},
      'draft': {'color': Colors.orange, 'label': 'Draft'},
      'published': {'color': Colors.purple, 'label': 'Published'},
    };

    final config =
        statusConfig[status] ?? {'color': Colors.grey, 'label': status};

    return Container(
      decoration: BoxDecoration(
        color: (config['color'] as Color).withValues(alpha: 10),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        config['label'] as String,
        style: TextStyle(
          fontSize: 11,
          color: config['color'] as Color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
