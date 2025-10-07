import 'package:fluent_ui/fluent_ui.dart';
import 'profile_tab.dart';
import 'appearance_tab.dart';
import 'preferences_tab.dart';
import 'notifications_tab.dart';
import 'data_management_tab.dart';

class SettingsTabs extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onChanged;

  const SettingsTabs({
    super.key,
    required this.currentIndex,
    required this.onChanged,
  });

  @override
  State<SettingsTabs> createState() => _SettingsTabsState();
}

class _SettingsTabsState extends State<SettingsTabs> {
  late List<Tab> _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = _generateTabs();
  }

  List<Tab> _generateTabs() {
    return [
      Tab(
        text: const Text('Profile'),
        semanticLabel: 'User Profile Settings',
        icon: const Icon(FluentIcons.contact),
        body: const ProfileTab(),
      ),
      Tab(
        text: const Text('Appearance'),
        semanticLabel: 'Appearance Settings',
        icon: const Icon(FluentIcons.color),
        body: const AppearanceTab(),
      ),
      Tab(
        text: const Text('Preferences'),
        semanticLabel: 'User Preferences',
        icon: const Icon(FluentIcons.settings),
        body: const PreferencesTab(),
      ),
      Tab(
        text: const Text('Notifications'),
        semanticLabel: 'Notification Settings',
        icon: const Icon(FluentIcons.ringer),
        body: const NotificationsTab(),
      ),
      Tab(
        text: const Text('Data & Privacy'),
        semanticLabel: 'Data Management Settings',
        icon: const Icon(FluentIcons.database),
        body: const DataManagementTab(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return TabView(
      tabs: _tabs,
      currentIndex: widget.currentIndex,
      onChanged: widget.onChanged,
      tabWidthBehavior: TabWidthBehavior.equal,
      closeButtonVisibility: CloseButtonVisibilityMode.never,
      showScrollButtons: true,
    );
  }
}
