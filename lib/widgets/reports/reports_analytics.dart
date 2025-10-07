import 'package:fluent_ui/fluent_ui.dart';

class ReportsAnalytics extends StatelessWidget {
  const ReportsAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Analytics',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            _buildMetric('Total Reports', '24', '+12%', Colors.blue),
            _buildMetric('Completion Rate', '92%', '+5%', Colors.green),
            _buildMetric('Avg Processing', '4.2min', '-1.3min', Colors.orange),
            _buildMetric('Data Accuracy', '98.5%', '+0.5%', Colors.purple),
          ],
        ),
      ),
    );
  }

  Widget _buildMetric(String label, String value, String change, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withValues(alpha: 10),
            child: Icon(_getMetricIcon(label), size: 16, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      value,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 10),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        change,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getMetricIcon(String label) {
    switch (label) {
      case 'Total Reports':
        return FluentIcons.report_document;
      case 'Completion Rate':
        return FluentIcons.check_mark;
      case 'Avg Processing':
        return FluentIcons.clock;
      case 'Data Accuracy':
        return FluentIcons.checkbox_composite;
      default:
        return FluentIcons.info;
    }
  }
}
