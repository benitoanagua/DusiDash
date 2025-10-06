import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: const PageHeader(title: Text('Settings')),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppearanceSection(context),
          const SizedBox(height: 16),
          _buildPreferencesSection(context),
        ],
      ),
    );
  }

  Widget _buildAppearanceSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Appearance',
              style: FluentTheme.of(context).typography.subtitle,
            ),
            const SizedBox(height: 16),
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return ToggleSwitch(
                  checked: themeProvider.isDark,
                  onChanged: (value) => themeProvider.toggleTheme(),
                  content: const Text('Dark Mode'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferencesSection(BuildContext context) {
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
            ComboBox<String>(
              placeholder: const Text('Language'),
              items: [
                ComboBoxItem(value: 'en', child: const Text('English')),
                ComboBoxItem(value: 'es', child: const Text('Spanish')),
              ],
            ),
            const SizedBox(height: 16),
            ComboBox<String>(
              placeholder: const Text('Date Format'),
              items: [
                ComboBoxItem(value: 'us', child: const Text('MM/DD/YYYY')),
                ComboBoxItem(value: 'eu', child: const Text('DD/MM/YYYY')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
