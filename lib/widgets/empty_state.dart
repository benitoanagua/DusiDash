import 'package:fluent_ui/fluent_ui.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Widget? action;

  const EmptyState({
    super.key,
    required this.title,
    required this.description,
    this.icon = FluentIcons.inbox,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.grey[60]),
          const SizedBox(height: 16),
          Text(title, style: FluentTheme.of(context).typography.subtitle),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: FluentTheme.of(context).typography.body,
          ),
          if (action != null) ...[const SizedBox(height: 16), action!],
        ],
      ),
    );
  }
}
