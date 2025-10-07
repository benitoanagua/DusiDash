import 'package:fluent_ui/fluent_ui.dart';
import 'settings_dialogs.dart';
import 'connected_device_item.dart';

class AccountSettingsSection extends StatelessWidget {
  const AccountSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expander(
          leading: const Icon(FluentIcons.lock),
          header: const Text('Change Password'),
          content: const _ChangePasswordContent(),
        ),
        const SizedBox(height: 8),
        Expander(
          leading: const Icon(FluentIcons.security_group),
          header: const Text('Two-Factor Authentication'),
          content: _TwoFactorContent(),
        ),
        const SizedBox(height: 8),
        Expander(
          leading: const Icon(FluentIcons.devices3),
          header: const Text('Connected Devices'),
          content: SizedBox(
            height: 200,
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  ConnectedDeviceItem(
                    name: 'Windows Desktop',
                    status: 'Active now',
                    isActive: true,
                  ),
                  ConnectedDeviceItem(
                    name: 'iPhone 14',
                    status: 'Last active 2h ago',
                    isActive: false,
                  ),
                  ConnectedDeviceItem(
                    name: 'iPad Pro',
                    status: 'Last active 1d ago',
                    isActive: false,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ChangePasswordContent extends StatelessWidget {
  const _ChangePasswordContent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          InfoLabel(
            label: 'Current Password',
            child: TextBox(
              placeholder: 'Enter current password',
              obscureText: true,
            ),
          ),
          const SizedBox(height: 12),
          InfoLabel(
            label: 'New Password',
            child: TextBox(
              placeholder: 'Enter new password',
              obscureText: true,
            ),
          ),
          const SizedBox(height: 12),
          InfoLabel(
            label: 'Confirm Password',
            child: TextBox(
              placeholder: 'Confirm new password',
              obscureText: true,
            ),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton(
              onPressed: () =>
                  SettingsDialogs.showSuccess(context, 'Password updated'),
              child: const Text('Update Password'),
            ),
          ),
        ],
      ),
    );
  }
}

class _TwoFactorContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add an extra layer of security to your account by enabling two-factor authentication.',
            style: FluentTheme.of(context).typography.body,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              FilledButton(
                onPressed: () =>
                    SettingsDialogs.showComingSoon(context, 'Two-Factor Auth'),
                child: const Text('Enable 2FA'),
              ),
              const SizedBox(width: 12),
              Button(
                onPressed: () =>
                    SettingsDialogs.showComingSoon(context, '2FA Setup Guide'),
                child: const Text('Learn More'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
