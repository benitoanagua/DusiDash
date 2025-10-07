import 'package:fluent_ui/fluent_ui.dart';
import 'settings_helpers.dart';
import 'notification_types_section.dart';

class NotificationsTab extends StatefulWidget {
  const NotificationsTab({super.key});

  @override
  State<NotificationsTab> createState() => _NotificationsTabState();
}

class _NotificationsTabState extends State<NotificationsTab> {
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _desktopNotifications = false;
  bool _soundEnabled = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsHelpers.buildSectionHeader(
            context,
            'Notification Preferences',
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SettingsHelpers.buildToggleOption(
                    context,
                    title: 'Email Notifications',
                    subtitle: 'Receive notifications via email',
                    value: _emailNotifications,
                    onChanged: (v) => setState(() => _emailNotifications = v),
                  ),
                  const SizedBox(height: 16),
                  SettingsHelpers.buildToggleOption(
                    context,
                    title: 'Push Notifications',
                    subtitle: 'Receive push notifications on your devices',
                    value: _pushNotifications,
                    onChanged: (v) => setState(() => _pushNotifications = v),
                  ),
                  const SizedBox(height: 16),
                  SettingsHelpers.buildToggleOption(
                    context,
                    title: 'Desktop Notifications',
                    subtitle: 'Show notifications on your desktop',
                    value: _desktopNotifications,
                    onChanged: (v) => setState(() => _desktopNotifications = v),
                  ),
                  const SizedBox(height: 16),
                  SettingsHelpers.buildToggleOption(
                    context,
                    title: 'Sound',
                    subtitle: 'Play sound for notifications',
                    value: _soundEnabled,
                    onChanged: (v) => setState(() => _soundEnabled = v),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          SettingsHelpers.buildSectionHeader(context, 'Notification Types'),
          const SizedBox(height: 16),
          const NotificationTypesSection(),
        ],
      ),
    );
  }
}
