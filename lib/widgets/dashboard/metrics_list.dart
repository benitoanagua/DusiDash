import 'package:fluent_ui/fluent_ui.dart';
import '../../providers/dashboard_provider.dart';

class MetricsList extends StatelessWidget {
  final DashboardProvider provider;

  const MetricsList({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    final metrics = provider.metrics;

    return Column(
      children: [
        _MetricItem(
          title: 'User Growth',
          value: metrics['userGrowth'] ?? '15%',
          color: Colors.green,
        ),
        _MetricItem(
          title: 'Revenue Growth',
          value: metrics['revenueGrowth'] ?? '12%',
          color: Colors.blue,
        ),
        _MetricItem(
          title: 'Engagement Rate',
          value: metrics['engagementRate'] ?? '75%',
          color: Colors.orange,
        ),
        _MetricItem(
          title: 'Conversion Rate',
          value: metrics['conversionRate'] ?? '8%',
          color: Colors.purple,
        ),
        _MetricItem(
          title: 'Satisfaction Score',
          value: metrics['satisfactionScore'] ?? '85/100',
          color: Colors.teal,
        ),
      ],
    );
  }
}

class _MetricItem extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _MetricItem({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(child: Text(title, style: const TextStyle(fontSize: 14))),
          Container(
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                value,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
