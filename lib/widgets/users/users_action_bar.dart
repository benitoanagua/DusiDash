import 'package:fluent_ui/fluent_ui.dart';
import '../../widgets/search_box.dart';

class UsersActionBar extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;

  const UsersActionBar({super.key, required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchBox(
            placeholder: 'Search users by name, email or role...',
            onChanged: onSearchChanged,
          ),
        ),
        const SizedBox(width: 16),
        CommandBar(
          overflowBehavior: CommandBarOverflowBehavior.noWrap,
          primaryItems: [
            CommandBarBuilderItem(
              builder: (context, mode, w) =>
                  Tooltip(message: 'Add a new user', child: w),
              wrappedItem: CommandBarButton(
                icon: const Icon(FluentIcons.add),
                label: const Text('Add User'),
                onPressed: () => _showAddUserDialog(context),
              ),
            ),
            const CommandBarSeparator(),
            CommandBarBuilderItem(
              builder: (context, mode, w) =>
                  Tooltip(message: 'Export user list', child: w),
              wrappedItem: CommandBarButton(
                icon: const Icon(FluentIcons.download),
                label: const Text('Export'),
                onPressed: () => _showComingSoon(context, 'Export'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showAddUserDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Add New User'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextBox(placeholder: 'Full Name'),
              const SizedBox(height: 12),
              TextBox(placeholder: 'Email Address'),
              const SizedBox(height: 12),
              ComboBox<String>(
                placeholder: const Text('Role'),
                items: const [
                  ComboBoxItem(value: 'admin', child: Text('Administrator')),
                  ComboBoxItem(value: 'manager', child: Text('Manager')),
                  ComboBoxItem(value: 'user', child: Text('User')),
                  ComboBoxItem(value: 'viewer', child: Text('Viewer')),
                ],
                onChanged: (value) {},
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
            child: const Text('Add User'),
            onPressed: () {
              Navigator.pop(context);
              displayInfoBar(
                context,
                builder: (context, close) {
                  return InfoBar(
                    title: const Text('Success'),
                    content: const Text('User added successfully'),
                    severity: InfoBarSeverity.success,
                    action: IconButton(
                      icon: const Icon(FluentIcons.clear),
                      onPressed: close,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
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
