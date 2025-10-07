import 'package:fluent_ui/fluent_ui.dart';
import 'settings_helpers.dart';

class PreferencesTab extends StatefulWidget {
  const PreferencesTab({super.key});

  @override
  State<PreferencesTab> createState() => _PreferencesTabState();
}

class _PreferencesTabState extends State<PreferencesTab> {
  String _selectedLanguage = 'en';
  String _selectedDateFormat = 'us';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsHelpers.buildSectionHeader(context, 'Language & Region'),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  InfoLabel(
                    label: 'Language',
                    child: ComboBox<String>(
                      value: _selectedLanguage,
                      items: const [
                        ComboBoxItem(value: 'en', child: Text('English')),
                        ComboBoxItem(value: 'es', child: Text('Español')),
                        ComboBoxItem(value: 'fr', child: Text('Français')),
                        ComboBoxItem(value: 'de', child: Text('Deutsch')),
                      ],
                      onChanged: (value) {
                        setState(() => _selectedLanguage = value!);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  InfoLabel(
                    label: 'Date Format',
                    child: ComboBox<String>(
                      value: _selectedDateFormat,
                      items: const [
                        ComboBoxItem(
                          value: 'us',
                          child: Text('MM/DD/YYYY (US)'),
                        ),
                        ComboBoxItem(
                          value: 'eu',
                          child: Text('DD/MM/YYYY (EU)'),
                        ),
                        ComboBoxItem(
                          value: 'iso',
                          child: Text('YYYY-MM-DD (ISO)'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() => _selectedDateFormat = value!);
                      },
                    ),
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
