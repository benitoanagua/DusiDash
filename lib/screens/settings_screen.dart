import 'package:fluent_ui/fluent_ui.dart';
import '../widgets/settings/settings_tabs.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: PageHeader(
        title: const Text('Settings'),
        commandBar: CommandBar(
          overflowBehavior: CommandBarOverflowBehavior.noWrap,
          primaryItems: [
            CommandBarBuilderItem(
              builder: (context, mode, w) =>
                  Tooltip(message: 'Reset all settings to default', child: w),
              wrappedItem: CommandBarButton(
                icon: const Icon(FluentIcons.refresh),
                label: const Text('Reset All'),
                onPressed: () => _showResetAllDialog(context),
              ),
            ),
            const CommandBarSeparator(),
            CommandBarBuilderItem(
              builder: (context, mode, w) =>
                  Tooltip(message: 'Export settings configuration', child: w),
              wrappedItem: CommandBarButton(
                icon: const Icon(FluentIcons.download),
                label: const Text('Export'),
                onPressed: () => _showComingSoon(context, 'Export Settings'),
              ),
            ),
          ],
        ),
      ),
      content: SettingsTabs(
        currentIndex: _currentTabIndex,
        onChanged: (index) => setState(() => _currentTabIndex = index),
      ),
    );
  }

  void _showResetAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Reset All Settings'),
        content: const Text(
          'Are you sure you want to reset ALL settings across all tabs? This cannot be undone.',
        ),
        actions: [
          Button(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          Button(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.red),
            ),
            child: const Text('Reset All'),
            onPressed: () {
              Navigator.pop(context);
              _showSuccessMessage(context, 'All settings reset to defaults');
            },
          ),
        ],
      ),
    );
  }

  void _showSuccessMessage(BuildContext context, String message) {
    displayInfoBar(
      context,
      builder: (context, close) {
        return InfoBar(
          title: const Text('Success'),
          content: Text(message),
          severity: InfoBarSeverity.success,
          action: IconButton(
            icon: const Icon(FluentIcons.clear),
            onPressed: close,
          ),
        );
      },
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: Text(feature),
        content: Text('$feature feature coming soon.'),
        actions: [
          Button(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
