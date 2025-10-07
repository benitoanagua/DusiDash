import 'package:fluent_ui/fluent_ui.dart';

class SettingsDialogs {
  static void showEditProfile(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Edit Profile'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InfoLabel(
                label: 'Full Name',
                child: TextBox(
                  placeholder: 'Enter your full name',
                  controller: TextEditingController(text: 'John Doe'),
                ),
              ),
              const SizedBox(height: 12),
              InfoLabel(
                label: 'Email Address',
                child: TextBox(
                  placeholder: 'Enter your email',
                  controller: TextEditingController(text: 'admin@dusidash.com'),
                ),
              ),
              const SizedBox(height: 12),
              InfoLabel(
                label: 'Phone Number',
                child: TextBox(
                  placeholder: 'Enter your phone',
                  controller: TextEditingController(text: '+1 234 567 8900'),
                ),
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
            onPressed: () {
              Navigator.pop(context);
              showSuccess(context, 'Profile updated successfully');
            },
          ),
        ],
      ),
    );
  }

  static void showExportData(BuildContext context) {
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
            onPressed: () {
              Navigator.pop(context);
              showSuccess(context, 'Data export started');
            },
          ),
        ],
      ),
    );
  }

  static void showClearCache(BuildContext context) {
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
            onPressed: () {
              Navigator.pop(context);
              showSuccess(context, 'Cache cleared successfully');
            },
          ),
        ],
      ),
    );
  }

  static void showResetSettings(BuildContext context) {
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
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.orange),
            ),
            child: const Text('Reset'),
            onPressed: () {
              Navigator.pop(context);
              showSuccess(context, 'Settings reset to defaults');
            },
          ),
        ],
      ),
    );
  }

  static void showSuccess(BuildContext context, String message) {
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

  static void showComingSoon(BuildContext context, String feature) {
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
