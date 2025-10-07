import 'package:fluent_ui/fluent_ui.dart';
import 'settings_helpers.dart';

class AppearanceTab extends StatefulWidget {
  const AppearanceTab({super.key});

  @override
  State<AppearanceTab> createState() => _AppearanceTabState();
}

class _AppearanceTabState extends State<AppearanceTab> {
  String _selectedTimezone = 'UTC';
  bool _compactMode = false;
  bool _showAnimations = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsHelpers.buildSectionHeader(context, 'Display Settings'),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  InfoLabel(
                    label: 'Timezone',
                    child: ComboBox<String>(
                      value: _selectedTimezone,
                      items: const [
                        ComboBoxItem(value: 'UTC', child: Text('UTC')),
                        ComboBoxItem(
                          value: 'America/New_York',
                          child: Text('Eastern Time (ET)'),
                        ),
                        ComboBoxItem(
                          value: 'America/Chicago',
                          child: Text('Central Time (CT)'),
                        ),
                        ComboBoxItem(
                          value: 'America/Denver',
                          child: Text('Mountain Time (MT)'),
                        ),
                        ComboBoxItem(
                          value: 'America/Los_Angeles',
                          child: Text('Pacific Time (PT)'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() => _selectedTimezone = value!);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  SettingsHelpers.buildToggleOption(
                    context,
                    title: 'Compact Mode',
                    subtitle: 'Reduce spacing and padding',
                    value: _compactMode,
                    onChanged: (v) => setState(() => _compactMode = v),
                  ),
                  const SizedBox(height: 16),
                  SettingsHelpers.buildToggleOption(
                    context,
                    title: 'Show Animations',
                    subtitle: 'Enable smooth transitions',
                    value: _showAnimations,
                    onChanged: (v) => setState(() => _showAnimations = v),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
