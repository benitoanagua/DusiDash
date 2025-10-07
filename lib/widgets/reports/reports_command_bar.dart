import 'package:fluent_ui/fluent_ui.dart';

class ReportsCommandBar extends StatelessWidget {
  final int selectedCount;
  final VoidCallback onGenerate;
  final VoidCallback onExport;

  const ReportsCommandBar({
    super.key,
    required this.selectedCount,
    required this.onGenerate,
    required this.onExport,
  });

  @override
  Widget build(BuildContext context) {
    return CommandBar(
      primaryItems: [
        CommandBarButton(
          icon: const Icon(FluentIcons.add),
          label: const Text('Generate'),
          onPressed: onGenerate,
        ),
        if (selectedCount > 0) ...[
          const CommandBarSeparator(),
          CommandBarButton(
            icon: const Icon(FluentIcons.delete),
            label: Text('Delete ($selectedCount)'),
            onPressed: () => _showDeleteDialog(context),
          ),
        ],
        const CommandBarSeparator(),
        CommandBarButton(
          icon: const Icon(FluentIcons.download),
          label: const Text('Export'),
          onPressed: onExport,
        ),
        CommandBarButton(
          icon: const Icon(FluentIcons.refresh),
          label: const Text('Refresh'),
          onPressed: () => _showSuccess(context, 'Data refreshed'),
        ),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Delete Reports'),
        content: Text('Delete $selectedCount reports?'),
        actions: [
          Button(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          Button(
            child: const Text('Delete'),
            onPressed: () {
              Navigator.pop(context);
              _showSuccess(context, 'Reports deleted');
            },
          ),
        ],
      ),
    );
  }

  void _showSuccess(BuildContext context, String message) {
    displayInfoBar(
      context,
      builder: (context, close) => InfoBar(
        title: const Text('Success'),
        content: Text(message),
        severity: InfoBarSeverity.success,
        action: IconButton(
          icon: const Icon(FluentIcons.clear),
          onPressed: close,
        ),
      ),
    );
  }
}
