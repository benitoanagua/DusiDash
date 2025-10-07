import 'package:fluent_ui/fluent_ui.dart';
import 'settings_dialogs.dart';

class ConnectedDeviceItem extends StatelessWidget {
  final String name;
  final String status;
  final bool isActive;

  const ConnectedDeviceItem({
    super.key,
    required this.name,
    required this.status,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        FluentIcons.devices3,
        color: isActive ? Colors.green : Colors.grey,
      ),
      title: Text(name),
      subtitle: Text(status),
      trailing: isActive
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Active',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : Button(
              onPressed: () =>
                  SettingsDialogs.showComingSoon(context, 'Remove Device'),
              child: const Text('Remove'),
            ),
    );
  }
}
