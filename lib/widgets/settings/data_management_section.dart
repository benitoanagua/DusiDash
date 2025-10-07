import 'package:fluent_ui/fluent_ui.dart';

class DataManagementSection extends StatelessWidget {
  final bool autoSave;
  final int autoSaveInterval;
  final ValueChanged<bool> onAutoSaveChanged;
  final ValueChanged<double> onAutoSaveIntervalChanged;
  final Function(BuildContext) onExportData;
  final Function(BuildContext) onClearCache;
  final Function(BuildContext) onResetSettings;

  const DataManagementSection({
    super.key,
    required this.autoSave,
    required this.autoSaveInterval,
    required this.onAutoSaveChanged,
    required this.onAutoSaveIntervalChanged,
    required this.onExportData,
    required this.onClearCache,
    required this.onResetSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Management',
              style: FluentTheme.of(context).typography.subtitle,
            ),
            const SizedBox(height: 16),
            ToggleSwitch(
              checked: autoSave,
              onChanged: onAutoSaveChanged,
              content: const Text('Auto-save Changes'),
            ),
            const SizedBox(height: 16),
            InfoLabel(
              label: 'Auto-save Interval (minutes)',
              child: Slider(
                min: 1,
                max: 30,
                value: autoSaveInterval.toDouble(),
                onChanged: autoSave ? onAutoSaveIntervalChanged : null,
                divisions: 29,
                label: '$autoSaveInterval',
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                FilledButton(
                  onPressed: () => onExportData(context),
                  child: const Row(
                    children: [
                      Icon(FluentIcons.download),
                      SizedBox(width: 8),
                      Text('Export All Data'),
                    ],
                  ),
                ),
                Button(
                  onPressed: () => onClearCache(context),
                  child: const Row(
                    children: [
                      Icon(FluentIcons.delete),
                      SizedBox(width: 8),
                      Text('Clear Cache'),
                    ],
                  ),
                ),
                Button(
                  onPressed: () => onResetSettings(context),
                  child: const Row(
                    children: [
                      Icon(FluentIcons.refresh),
                      SizedBox(width: 8),
                      Text('Reset to Defaults'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
