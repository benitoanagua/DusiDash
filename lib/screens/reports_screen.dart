import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/reports/reports_content.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String _selectedReportType = 'all';
  final _commandBarKey = GlobalKey<CommandBarState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: const PageHeader(title: Text('Reports & Analytics')),
      content: Consumer<DashboardProvider>(
        builder: (context, dashboardProvider, child) {
          final filteredReports = _selectedReportType == 'all'
              ? dashboardProvider.reports
              : dashboardProvider.reports
                    .where((report) => report.type == _selectedReportType)
                    .toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildActionBar(context),
              const SizedBox(height: 24),
              _buildReportFilters(context, filteredReports.length),
              const SizedBox(height: 24),
              Expanded(
                child: ReportsContent(
                  reports: filteredReports,
                  selectedReportType: _selectedReportType,
                  onReportTypeChanged: (value) {
                    setState(() {
                      _selectedReportType = value;
                    });
                  },
                  onShowComingSoon: (feature) =>
                      _showComingSoonDialog(context, feature),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildActionBar(BuildContext context) {
    return CommandBar(
      key: _commandBarKey,
      overflowBehavior: CommandBarOverflowBehavior.dynamicOverflow,
      primaryItems: [
        CommandBarBuilderItem(
          builder: (context, mode, w) =>
              Tooltip(message: 'Generate a new report', child: w),
          wrappedItem: CommandBarButton(
            icon: const Icon(FluentIcons.add),
            label: const Text('Generate Report'),
            onPressed: () => _generateNewReport(context),
          ),
        ),
        const CommandBarSeparator(),
        CommandBarBuilderItem(
          builder: (context, mode, w) =>
              Tooltip(message: 'Export all reports', child: w),
          wrappedItem: CommandBarButton(
            icon: const Icon(FluentIcons.download),
            label: const Text('Export All'),
            onPressed: () => _showComingSoonDialog(context, 'Export All'),
          ),
        ),
        CommandBarBuilderItem(
          builder: (context, mode, w) =>
              Tooltip(message: 'Print reports', child: w),
          wrappedItem: CommandBarButton(
            icon: const Icon(FluentIcons.print),
            label: const Text('Print'),
            onPressed: () => _showComingSoonDialog(context, 'Print'),
          ),
        ),
        CommandBarBuilderItem(
          builder: (context, mode, w) =>
              Tooltip(message: 'Schedule report generation', child: w),
          wrappedItem: CommandBarButton(
            icon: const Icon(FluentIcons.calendar),
            label: const Text('Schedule'),
            onPressed: () => _showComingSoonDialog(context, 'Schedule'),
          ),
        ),
      ],
    );
  }

  Widget _buildReportFilters(BuildContext context, int reportCount) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text(
              'Filter by:',
              style: FluentTheme.of(context).typography.bodyStrong,
            ),
            const SizedBox(width: 16),
            ComboBox<String>(
              value: _selectedReportType,
              items: const [
                ComboBoxItem(value: 'all', child: Text('All Reports')),
                ComboBoxItem(value: 'financial', child: Text('Financial')),
                ComboBoxItem(value: 'performance', child: Text('Performance')),
                ComboBoxItem(value: 'audit', child: Text('Audit')),
                ComboBoxItem(value: 'analytics', child: Text('Analytics')),
                ComboBoxItem(value: 'compliance', child: Text('Compliance')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedReportType = value!;
                });
              },
            ),
            const Spacer(),
            Text(
              '$reportCount reports found',
              style: TextStyle(color: Colors.grey[100]),
            ),
          ],
        ),
      ),
    );
  }

  void _generateNewReport(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Generate New Report'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ComboBox<String>(
                placeholder: const Text('Report Type'),
                items: const [
                  ComboBoxItem(
                    value: 'financial',
                    child: Text('Financial Report'),
                  ),
                  ComboBoxItem(
                    value: 'performance',
                    child: Text('Performance Report'),
                  ),
                  ComboBoxItem(
                    value: 'analytics',
                    child: Text('Analytics Report'),
                  ),
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
            child: const Text('Generate'),
            onPressed: () {
              Navigator.pop(context);
              _showSuccessMessage(context, 'Report generation started');
            },
          ),
        ],
      ),
    );
  }

  void _showSuccessMessage(BuildContext context, String message) {
    displayInfoBar(
      context,
      builder: (context, close) {
        return InfoBar(
          title: const Text('Success'),
          content: Text(message),
          severity: InfoBarSeverity.success,
          action: IconButton(
            icon: const Icon(FluentIcons.clear),
            onPressed: close,
          ),
        );
      },
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
