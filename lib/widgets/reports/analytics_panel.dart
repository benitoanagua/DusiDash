import 'package:fluent_ui/fluent_ui.dart';
import 'analytics_item.dart';
import 'quick_action_button.dart';

class AnalyticsPanel extends StatelessWidget {
  final Function(String) onShowComingSoon;

  const AnalyticsPanel({super.key, required this.onShowComingSoon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAnalyticsCard(context),
        const SizedBox(height: 16),
        _buildQuickActionsCard(context),
      ],
    );
  }

  Widget _buildAnalyticsCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Report Analytics',
              style: FluentTheme.of(context).typography.subtitle,
            ),
            const SizedBox(height: 16),
            AnalyticsItem(
              label: 'Total Reports Generated',
              value: '24',
              change: '+12%',
              isPositive: true,
              icon: FluentIcons.report_document,
              color: Colors.blue,
            ),
            AnalyticsItem(
              label: 'Completion Rate',
              value: '92%',
              change: '+5%',
              isPositive: true,
              icon: FluentIcons.check_mark,
              color: Colors.green,
            ),
            AnalyticsItem(
              label: 'Average Processing Time',
              value: '4.2min',
              change: '-1.3min',
              isPositive: true,
              icon: FluentIcons.clock,
              color: Colors.orange,
            ),
            AnalyticsItem(
              label: 'Data Accuracy',
              value: '98.5%',
              change: '+0.5%',
              isPositive: true,
              icon: FluentIcons.checkbox_composite,
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionsCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: FluentTheme.of(context).typography.subtitle,
            ),
            const SizedBox(height: 16),
            QuickActionButton(
              icon: FluentIcons.bar_chart4,
              label: 'View Dashboard',
              onPressed: () => onShowComingSoon('View Dashboard'),
            ),
            QuickActionButton(
              icon: FluentIcons.data_flow,
              label: 'Data Sources',
              onPressed: () => onShowComingSoon('Data Sources'),
            ),
            QuickActionButton(
              icon: FluentIcons.settings,
              label: 'Report Settings',
              onPressed: () => onShowComingSoon('Report Settings'),
            ),
            QuickActionButton(
              icon: FluentIcons.help,
              label: 'Help & Documentation',
              onPressed: () => onShowComingSoon('Help & Documentation'),
            ),
          ],
        ),
      ),
    );
  }
}
