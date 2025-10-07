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
        FilledButton(
          onPressed: () => _showComingSoonDialog(context, 'Add User'),
          child: const Row(
            children: [
              Icon(FluentIcons.add),
              SizedBox(width: 8),
              Text('Add User'),
            ],
          ),
        ),
      ],
    );
  }

  void _showComingSoonDialog(BuildContext context, String feature) {
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
