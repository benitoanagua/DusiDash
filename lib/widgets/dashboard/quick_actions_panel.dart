import 'package:fluent_ui/fluent_ui.dart';
import 'quick_action_button.dart';

class QuickActionsPanel extends StatelessWidget {
  const QuickActionsPanel({super.key});

  @override
  Widget build(BuildContext context) {
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
            const Column(
              children: [
                QuickActionButton(
                  icon: FluentIcons.add,
                  label: 'Add User',
                  feature: 'Add User',
                ),
                QuickActionButton(
                  icon: FluentIcons.report_document,
                  label: 'Generate Report',
                  feature: 'Generate Report',
                ),
                QuickActionButton(
                  icon: FluentIcons.bar_chart4,
                  label: 'View Analytics',
                  feature: 'View Analytics',
                ),
                QuickActionButton(
                  icon: FluentIcons.download,
                  label: 'Export Data',
                  feature: 'Export Data',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
