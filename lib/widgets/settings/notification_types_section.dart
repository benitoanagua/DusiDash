import 'package:fluent_ui/fluent_ui.dart';

class NotificationTypesSection extends StatefulWidget {
  const NotificationTypesSection({super.key});

  @override
  State<NotificationTypesSection> createState() =>
      _NotificationTypesSectionState();
}

class _NotificationTypesSectionState extends State<NotificationTypesSection> {
  // Estado para los checkboxes
  bool _newFeatures = true;
  bool _maintenanceNotices = true;
  bool _securityUpdates = true;
  bool _newUserRegistrations = true;
  bool _userStatusChanges = false;
  bool _reportCompletion = true;
  bool _scheduledReports = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expander(
          leading: const Icon(FluentIcons.mail),
          header: const Text('System Updates'),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                _buildCheckboxItem(
                  'New features',
                  _newFeatures,
                  (v) => setState(() => _newFeatures = v ?? false),
                ),
                _buildCheckboxItem(
                  'Maintenance notices',
                  _maintenanceNotices,
                  (v) => setState(() => _maintenanceNotices = v ?? false),
                ),
                _buildCheckboxItem(
                  'Security updates',
                  _securityUpdates,
                  (v) => setState(() => _securityUpdates = v ?? false),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expander(
          leading: const Icon(FluentIcons.people),
          header: const Text('User Activity'),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                _buildCheckboxItem(
                  'New user registrations',
                  _newUserRegistrations,
                  (v) => setState(() => _newUserRegistrations = v ?? false),
                ),
                _buildCheckboxItem(
                  'User status changes',
                  _userStatusChanges,
                  (v) => setState(() => _userStatusChanges = v ?? false),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expander(
          leading: const Icon(FluentIcons.report_document),
          header: const Text('Reports'),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                _buildCheckboxItem(
                  'Report completion',
                  _reportCompletion,
                  (v) => setState(() => _reportCompletion = v ?? false),
                ),
                _buildCheckboxItem(
                  'Scheduled reports',
                  _scheduledReports,
                  (v) => setState(() => _scheduledReports = v ?? false),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckboxItem(
    String label,
    bool value,
    ValueChanged<bool?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Checkbox(checked: value, onChanged: onChanged),
          const SizedBox(width: 8),
          Expanded(child: Text(label)),
        ],
      ),
    );
  }
}
