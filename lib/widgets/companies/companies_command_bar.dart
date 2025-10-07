import 'package:fluent_ui/fluent_ui.dart';

class CompaniesCommandBar extends StatelessWidget {
  final int selectedCount;
  final VoidCallback onAddCompany;
  final VoidCallback onRefresh;
  final VoidCallback onExport;

  const CompaniesCommandBar({
    super.key,
    required this.selectedCount,
    required this.onAddCompany,
    required this.onRefresh,
    required this.onExport,
  });

  @override
  Widget build(BuildContext context) {
    return CommandBar(
      primaryItems: [
        CommandBarButton(
          icon: const Icon(FluentIcons.add),
          label: const Text('Add Company'),
          onPressed: onAddCompany,
        ),
        if (selectedCount > 0) ...[
          const CommandBarSeparator(),
          CommandBarButton(
            icon: const Icon(FluentIcons.delete),
            label: Text('Delete ($selectedCount)'),
            onPressed: () => _showBulkDeleteDialog(context),
          ),
        ],
        const CommandBarSeparator(),
        CommandBarButton(
          icon: const Icon(FluentIcons.refresh),
          label: const Text('Refresh'),
          onPressed: onRefresh,
        ),
        CommandBarButton(
          icon: const Icon(FluentIcons.download),
          label: const Text('Export'),
          onPressed: onExport,
        ),
      ],
    );
  }

  void _showBulkDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Delete Companies'),
        content: Text(
          'Are you sure you want to delete $selectedCount companies?',
        ),
        actions: [
          Button(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          Button(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.red),
            ),
            child: const Text('Delete'),
            onPressed: () {
              Navigator.pop(context);
              // Implement bulk delete
            },
          ),
        ],
      ),
    );
  }
}
