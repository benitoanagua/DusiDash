import 'package:fluent_ui/fluent_ui.dart';
import 'settings_helpers.dart';
import 'settings_dialogs.dart';

class DataManagementTab extends StatefulWidget {
  const DataManagementTab({super.key});

  @override
  State<DataManagementTab> createState() => _DataManagementTabState();
}

class _DataManagementTabState extends State<DataManagementTab> {
  bool _autoSave = true;
  int _autoSaveInterval = 5;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsHelpers.buildSectionHeader(context, 'Auto-Save Settings'),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SettingsHelpers.buildToggleOption(
                    context,
                    title: 'Enable Auto-Save',
                    subtitle: 'Automatically save your work',
                    value: _autoSave,
                    onChanged: (v) => setState(() => _autoSave = v),
                  ),
                  if (_autoSave) ...[
                    const SizedBox(height: 20),
                    InfoLabel(
                      label: 'Auto-Save Interval (minutes)',
                      child: Slider(
                        value: _autoSaveInterval.toDouble(),
                        min: 1,
                        max: 30,
                        divisions: 29,
                        label: '$_autoSaveInterval min',
                        onChanged: (v) {
                          setState(() => _autoSaveInterval = v.toInt());
                        },
                      ),
                    ),
                    Text(
                      'Current interval: $_autoSaveInterval minutes',
                      style: FluentTheme.of(context).typography.caption,
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          SettingsHelpers.buildSectionHeader(context, 'Data Management'),
          const SizedBox(height: 16),
          _buildDataManagementActions(context),
        ],
      ),
    );
  }

  Widget _buildDataManagementActions(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
            leading: const Icon(FluentIcons.download),
            title: const Text('Export Data'),
            subtitle: const Text('Download all your data in CSV format'),
            trailing: Button(
              onPressed: () => SettingsDialogs.showExportData(context),
              child: const Text('Export'),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            leading: const Icon(FluentIcons.delete),
            title: const Text('Clear Cache'),
            subtitle: const Text('Free up space by clearing cached data'),
            trailing: Button(
              onPressed: () => SettingsDialogs.showClearCache(context),
              child: const Text('Clear'),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            leading: const Icon(FluentIcons.refresh),
            title: const Text('Reset Settings'),
            subtitle: const Text('Restore all settings to default values'),
            trailing: Button(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.orange),
              ),
              onPressed: () => SettingsDialogs.showResetSettings(context),
              child: const Text('Reset'),
            ),
          ),
        ),
      ],
    );
  }
}
