import 'package:fluent_ui/fluent_ui.dart';

class QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String feature;

  const QuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.feature,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: FilledButton(
        onPressed: () => _showComingSoonDialog(context, feature),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 8),
            Expanded(child: Text(label)),
          ],
        ),
      ),
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
