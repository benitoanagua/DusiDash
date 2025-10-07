import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/auth_provider.dart';

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
            _buildUserProfileSection(context),
            const SizedBox(height: 24),
            _buildAppearanceSection(context),
            const SizedBox(height: 24),
            _buildPreferencesSection(context),
            const SizedBox(height: 24),
            _buildNotificationsSection(context),
            const SizedBox(height: 24),
            _buildDataManagementSection(context),
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
            InfoLabel(
              label: 'Language',
              child: ComboBox<String>(
                value: _selectedLanguage,
                items: const [
                  ComboBoxItem(value: 'en', child: Text('English')),
                  ComboBoxItem(value: 'es', child: Text('Spanish')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            InfoLabel(
              label: 'Date Format',
              child: ComboBox<String>(
                value: _selectedDateFormat,
                items: const [
                  ComboBoxItem(value: 'us', child: Text('MM/DD/YYYY')),
                  ComboBoxItem(value: 'eu', child: Text('DD/MM/YYYY')),
                  ComboBoxItem(value: 'iso', child: Text('YYYY-MM-DD')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedDateFormat = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfileSection(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Profile',
              style: FluentTheme.of(context).typography.subtitle,
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  child: Text(
                    authProvider.currentUser?.name
                            .substring(0, 2)
                            .toUpperCase() ??
                        'U',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authProvider.currentUser?.name ?? 'User Name',
                        style: FluentTheme.of(context).typography.title,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        authProvider.currentUser?.email ?? 'user@example.com',
                        style: TextStyle(color: Colors.grey[100]),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        authProvider.currentUser?.role ?? 'User Role',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                FilledButton(
                  onPressed: () => _editProfile(context),
                  child: const Row(
                    children: [
                      Icon(FluentIcons.edit),
                      SizedBox(width: 8),
                      Text('Edit Profile'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _ProfileStat(
                  label: 'Member Since',
                  value: _formatJoinDate(authProvider.currentUser?.joinDate),
                  icon: FluentIcons.calendar,
                ),
                _ProfileStat(
                  label: 'Last Login',
                  value: _formatLastLogin(authProvider.currentUser?.lastLogin),
                  icon: FluentIcons.clock,
                ),
                _ProfileStat(
                  label: 'Status',
                  value: authProvider.currentUser?.isActive == true
                      ? 'Active'
                      : 'Inactive',
                  icon: FluentIcons.status_circle_checkmark,
                  color: authProvider.currentUser?.isActive == true
                      ? Colors.green
                      : Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppearanceSection(BuildContext context) {
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
                  _ColorOption(color: Colors.blue, isSelected: true),
                  _ColorOption(color: Colors.green),
                  _ColorOption(color: Colors.purple),
                  _ColorOption(color: Colors.orange),
                  _ColorOption(color: Colors.teal),
                  _ColorOption(color: Colors.magenta),
                ],
              ),
            ),
            const SizedBox(height: 16),
            InfoLabel(
              label: 'Font Size',
              child: Slider(
                min: 12,
                max: 24,
                value: 16,
                onChanged: (value) {
                  setState(() {
                    _selectedDateFormat = value.toString();
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            InfoLabel(
              label: 'Timezone',
              child: ComboBox<String>(
                value: _selectedTimezone,
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
                  setState(() {
                    _selectedTimezone = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsSection(BuildContext context) {
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
              checked: _emailNotifications,
              onChanged: (value) {
                setState(() {
                  _emailNotifications = value;
                });
              },
              content: const Text('Email Notifications'),
            ),
            const SizedBox(height: 12),
            ToggleSwitch(
              checked: _pushNotifications,
              onChanged: (value) {
                setState(() {
                  _pushNotifications = value;
                });
              },
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

  Widget _buildDataManagementSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Management',
              style: FluentTheme.of(context).typography.subtitle,
            ),
            const SizedBox(height: 16),
            ToggleSwitch(
              checked: _autoSave,
              onChanged: (value) {
                setState(() {
                  _autoSave = value;
                });
              },
              content: const Text('Auto-save Changes'),
            ),
            const SizedBox(height: 16),
            InfoLabel(
              label: 'Auto-save Interval (minutes)',
              child: Slider(
                min: 1,
                max: 30,
                value: _autoSaveInterval.toDouble(),
                onChanged: _autoSave
                    ? (value) {
                        setState(() {
                          _autoSaveInterval = value.toInt();
                        });
                      }
                    : null,
                divisions: 29,
                label: '$_autoSaveInterval',
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                FilledButton(
                  onPressed: () => _exportData(context),
                  child: const Row(
                    children: [
                      Icon(FluentIcons.download),
                      SizedBox(width: 8),
                      Text('Export All Data'),
                    ],
                  ),
                ),
                Button(
                  onPressed: () => _clearCache(context),
                  child: const Row(
                    children: [
                      Icon(FluentIcons.delete),
                      SizedBox(width: 8),
                      Text('Clear Cache'),
                    ],
                  ),
                ),
                Button(
                  onPressed: () => _showResetDialog(context),
                  child: const Row(
                    children: [
                      Icon(FluentIcons.refresh),
                      SizedBox(width: 8),
                      Text('Reset to Defaults'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatJoinDate(DateTime? date) {
    if (date == null) return 'Unknown';
    return '${date.month}/${date.year}';
  }

  String _formatLastLogin(DateTime? date) {
    if (date == null) return 'Never';
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
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

class _ProfileStat extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? color;

  const _ProfileStat({
    required this.label,
    required this.value,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[30]),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color ?? Colors.blue),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorOption extends StatelessWidget {
  final Color color;
  final bool isSelected;

  const _ColorOption({required this.color, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 10),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: isSelected
          ? const Icon(FluentIcons.check_mark, size: 16, color: Colors.white)
          : null,
    );
  }
}
