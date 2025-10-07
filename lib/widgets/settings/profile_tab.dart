import 'package:fluent_ui/fluent_ui.dart';
import 'profile_card.dart';
import 'account_settings_section.dart';
import 'settings_helpers.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsHelpers.buildSectionHeader(context, 'User Information'),
          const SizedBox(height: 16),
          const ProfileCard(),
          const SizedBox(height: 24),
          SettingsHelpers.buildSectionHeader(context, 'Account Settings'),
          const SizedBox(height: 16),
          const AccountSettingsSection(),
        ],
      ),
    );
  }
}
