import 'package:fluent_ui/fluent_ui.dart';

class NotificationsSection extends StatelessWidget {
  final bool emailNotifications;
  final bool pushNotifications;
  final ValueChanged<bool> onEmailNotificationsChanged;
  final ValueChanged<bool> onPushNotificationsChanged;

  const NotificationsSection({
    super.key,
    required this.emailNotifications,
    required this.pushNotifications,
    required this.onEmailNotificationsChanged,
    required this.onPushNotificationsChanged,
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
              'Notifications',
              style: FluentTheme.of(context).typography.subtitle,
            ),
            const SizedBox(height: 16),
            ToggleSwitch(
              checked: emailNotifications,
              onChanged: onEmailNotificationsChanged,
              content: const Text('Email Notifications'),
            ),
            const SizedBox(height: 12),
            ToggleSwitch(
              checked: pushNotifications,
              onChanged: onPushNotificationsChanged,
              content: const Text('Push Notifications'),
            ),
            const SizedBox(height: 16),
            InfoLabel(
              label: 'Notification Frequency',
              child: ComboBox<String>(
                value: 'immediate',
                items: const [
                  ComboBoxItem(value: 'immediate', child: Text('Immediate')),
                  ComboBoxItem(value: 'daily', child: Text('Daily Digest')),
                  ComboBoxItem(value: 'weekly', child: Text('Weekly Summary')),
                ],
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
