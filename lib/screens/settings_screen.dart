import 'package:fluent_ui/fluent_ui.dart';
import '../widgets/settings/user_profile_section.dart';
import '../widgets/settings/appearance_section.dart';
import '../widgets/settings/preferences_section.dart';
import '../widgets/settings/notifications_section.dart';
import '../widgets/settings/data_management_section.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedLanguage = 'en';
  String _selectedDateFormat = 'us';
  String _selectedTimezone = 'UTC';
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _autoSave = true;
  int _autoSaveInterval = 5;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: const PageHeader(title: Text('Settings')),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserProfileSection(onEditProfile: _editProfile),
            const SizedBox(height: 24),
            AppearanceSection(
              selectedTimezone: _selectedTimezone,
              onTimezoneChanged: (value) {
                setState(() {
                  _selectedTimezone = value;
                });
              },
            ),
            const SizedBox(height: 24),
            PreferencesSection(
              selectedLanguage: _selectedLanguage,
              selectedDateFormat: _selectedDateFormat,
              onLanguageChanged: (value) {
                setState(() {
                  _selectedLanguage = value;
                });
              },
              onDateFormatChanged: (value) {
                setState(() {
                  _selectedDateFormat = value;
                });
              },
            ),
            const SizedBox(height: 24),
            NotificationsSection(
              emailNotifications: _emailNotifications,
              pushNotifications: _pushNotifications,
              onEmailNotificationsChanged: (value) {
                setState(() {
                  _emailNotifications = value;
                });
              },
              onPushNotificationsChanged: (value) {
                setState(() {
                  _pushNotifications = value;
                });
              },
            ),
            const SizedBox(height: 24),
            DataManagementSection(
              autoSave: _autoSave,
              autoSaveInterval: _autoSaveInterval,
              onAutoSaveChanged: (value) {
                setState(() {
                  _autoSave = value;
                });
              },
              onAutoSaveIntervalChanged: (value) {
                setState(() {
                  _autoSaveInterval = value.toInt();
                });
              },
              onExportData: _exportData,
              onClearCache: _clearCache,
              onResetSettings: _showResetDialog,
            ),
          ],
        ),
      ),
    );
  }

  void _editProfile(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Edit Profile'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextBox(placeholder: 'Full Name'),
              const SizedBox(height: 12),
              TextBox(placeholder: 'Email Address'),
              const SizedBox(height: 12),
              TextBox(placeholder: 'Phone Number'),
              const SizedBox(height: 12),
              ComboBox<String>(
                placeholder: const Text('Role'),
                items: const [
                  ComboBoxItem(value: 'admin', child: Text('Administrator')),
                  ComboBoxItem(value: 'manager', child: Text('Manager')),
                  ComboBoxItem(value: 'user', child: Text('User')),
                ],
              ),
            ],
          ),
        ),
        actions: [
          Button(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          FilledButton(
            child: const Text('Save Changes'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _exportData(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Export Data'),
        content: const Text(
          'Your data will be exported in CSV format. This may take a few minutes.',
        ),
        actions: [
          Button(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          FilledButton(
            child: const Text('Export'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _clearCache(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Clear Cache'),
        content: const Text(
          'This will clear all cached data. Your personal settings and data will not be affected.',
        ),
        actions: [
          Button(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          FilledButton(
            child: const Text('Clear Cache'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Reset Settings'),
        content: const Text(
          'This will reset all settings to their default values. This action cannot be undone.',
        ),
        actions: [
          Button(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          Button(
            child: const Text('Reset'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
