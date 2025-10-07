import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/reports/reports_command_bar.dart';
import '../widgets/reports/reports_filters.dart';
import '../widgets/reports/reports_list.dart';
import '../widgets/reports/reports_analytics.dart';
import '../widgets/reports/reports_actions.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String _selectedReportType = 'all';
  final List<String> _selectedReports = [];

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: PageHeader(
        title: const Text('Reports & Analytics'),
        commandBar: ReportsCommandBar(
          selectedCount: _selectedReports.length,
          onGenerate: _showGenerateDialog,
          onExport: _showExportDialog,
        ),
      ),
      content: Consumer<DashboardProvider>(
        builder: (context, dashboardProvider, child) {
          final filteredReports = _getFilteredReports(
            dashboardProvider.reports,
          );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReportsFilters(
                selectedType: _selectedReportType,
                reportCount: filteredReports.length,
                selectedCount: _selectedReports.length,
                onTypeChanged: (type) =>
                    setState(() => _selectedReportType = type),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: ReportsList(
                        reports: filteredReports,
                        selectedReports: _selectedReports,
                        onSelectionChanged: (selected) => setState(
                          () => _selectedReports
                            ..clear()
                            ..addAll(selected),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          ReportsAnalytics(),
                          SizedBox(height: 16),
                          ReportsActions(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List _getFilteredReports(List allReports) {
    if (_selectedReportType == 'all') return allReports;
    return allReports
        .where((report) => report.type == _selectedReportType)
        .toList();
  }

  void _showGenerateDialog() {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Generate Report'),
        content: const Text('Select report type and parameters.'),
        actions: [
          Button(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          FilledButton(
            child: const Text('Generate'),
            onPressed: () {
              Navigator.pop(context);
              _showSuccess('Report generation started');
            },
          ),
        ],
      ),
    );
  }

  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Export Reports'),
        content: const Text('Choose export format and options.'),
        actions: [
          Button(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          FilledButton(
            child: const Text('Export'),
            onPressed: () {
              Navigator.pop(context);
              _showSuccess('Export completed');
            },
          ),
        ],
      ),
    );
  }

  void _showSuccess(String message) {
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
