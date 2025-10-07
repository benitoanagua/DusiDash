import 'package:fluent_ui/fluent_ui.dart';

class ReportsFilters extends StatelessWidget {
  final String selectedType;
  final int reportCount;
  final int selectedCount;
  final ValueChanged<String> onTypeChanged;

  const ReportsFilters({
    super.key,
    required this.selectedType,
    required this.reportCount,
    required this.selectedCount,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Text(
              'Filter:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 12),
            ComboBox<String>(
              value: selectedType,
              items: const [
                ComboBoxItem(value: 'all', child: Text('All Reports')),
                ComboBoxItem(value: 'financial', child: Text('Financial')),
                ComboBoxItem(value: 'performance', child: Text('Performance')),
                ComboBoxItem(value: 'analytics', child: Text('Analytics')),
              ],
              onChanged: (value) => onTypeChanged(value!),
            ),
            const Spacer(),
            Text('$reportCount reports'),
            if (selectedCount > 0) ...[
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$selectedCount selected',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
