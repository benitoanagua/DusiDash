import 'package:fluent_ui/fluent_ui.dart';
import '../../providers/dashboard_provider.dart';
import 'metrics_list.dart';
import 'recent_users_list.dart';

class MetricsPanel extends StatelessWidget {
  final DashboardProvider provider;

  const MetricsPanel({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Performance Metrics',
              style: FluentTheme.of(context).typography.subtitle,
            ),
            const SizedBox(height: 16),
            MetricsList(provider: provider),
            const SizedBox(height: 24),
            Text(
              'Recent Users',
              style: FluentTheme.of(context).typography.subtitle,
            ),
            const SizedBox(height: 16),
            Expanded(child: RecentUsersList(provider: provider)),
          ],
        ),
      ),
    );
  }
}
