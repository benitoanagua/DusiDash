import 'package:fluent_ui/fluent_ui.dart';

class ReportsActions extends StatelessWidget {
  const ReportsActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            _buildActionButton('View Dashboard', FluentIcons.dashboard_add),
            _buildActionButton('Data Sources', FluentIcons.database),
            _buildActionButton('Settings', FluentIcons.settings),
            _buildActionButton('Help', FluentIcons.help),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: FilledButton(
        onPressed: () => _showComingSoon(label),
        child: Row(
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 8),
            Expanded(child: Text(label)),
          ],
        ),
      ),
    );
  }

  void _showComingSoon(String feature) {
    // This would typically show a dialog or info bar
  }
}
