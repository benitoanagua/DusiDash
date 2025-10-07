import 'package:fluent_ui/fluent_ui.dart';

class PreferencesSection extends StatelessWidget {
  final String selectedLanguage;
  final String selectedDateFormat;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<String> onDateFormatChanged;

  const PreferencesSection({
    super.key,
    required this.selectedLanguage,
    required this.selectedDateFormat,
    required this.onLanguageChanged,
    required this.onDateFormatChanged,
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
              'Preferences',
              style: FluentTheme.of(context).typography.subtitle,
            ),
            const SizedBox(height: 16),
            InfoLabel(
              label: 'Language',
              child: ComboBox<String>(
                value: selectedLanguage,
                items: const [
                  ComboBoxItem(value: 'en', child: Text('English')),
                  ComboBoxItem(value: 'es', child: Text('Spanish')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    onLanguageChanged(value);
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            InfoLabel(
              label: 'Date Format',
              child: ComboBox<String>(
                value: selectedDateFormat,
                items: const [
                  ComboBoxItem(value: 'us', child: Text('MM/DD/YYYY')),
                  ComboBoxItem(value: 'eu', child: Text('DD/MM/YYYY')),
                  ComboBoxItem(value: 'iso', child: Text('YYYY-MM-DD')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    onDateFormatChanged(value);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
