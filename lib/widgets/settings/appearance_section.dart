import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import 'color_option.dart';

class AppearanceSection extends StatelessWidget {
  final String selectedTimezone;
  final ValueChanged<String> onTimezoneChanged;

  const AppearanceSection({
    super.key,
    required this.selectedTimezone,
    required this.onTimezoneChanged,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

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
            ToggleSwitch(
              checked: themeProvider.isDark,
              onChanged: (value) => themeProvider.toggleTheme(),
              content: const Text('Dark Mode'),
            ),
            const SizedBox(height: 16),
            InfoLabel(
              label: 'Accent Color',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ColorOption(color: Colors.blue, isSelected: true),
                  ColorOption(color: Colors.green),
                  ColorOption(color: Colors.purple),
                  ColorOption(color: Colors.orange),
                  ColorOption(color: Colors.teal),
                  ColorOption(color: Colors.magenta),
                ],
              ),
            ),
            const SizedBox(height: 16),
            InfoLabel(
              label: 'Font Size',
              child: Slider(min: 12, max: 24, value: 16, onChanged: (value) {}),
            ),
            const SizedBox(height: 16),
            InfoLabel(
              label: 'Timezone',
              child: ComboBox<String>(
                value: selectedTimezone,
                items: const [
                  ComboBoxItem(value: 'UTC', child: Text('UTC')),
                  ComboBoxItem(value: 'est', child: Text('Eastern Time')),
                  ComboBoxItem(value: 'pst', child: Text('Pacific Time')),
                  ComboBoxItem(
                    value: 'cet',
                    child: Text('Central European Time'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    onTimezoneChanged(value);
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
