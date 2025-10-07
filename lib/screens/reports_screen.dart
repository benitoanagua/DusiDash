import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../providers/dashboard_provider.dart';
import '../core/data/faker_service.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String _selectedReportType = 'all';

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
                child: _ReportsContent(
                  reports: filteredReports,
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
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        FilledButton(
          onPressed: () => _generateNewReport(context),
          child: const Row(
            children: [
              Icon(FluentIcons.add),
              SizedBox(width: 8),
              Text('Generate Report'),
            ],
          ),
        ),
        FilledButton(
          onPressed: () => _showComingSoonDialog(context, 'Export All'),
          child: const Row(
            children: [
              Icon(FluentIcons.download),
              SizedBox(width: 8),
              Text('Export All'),
            ],
          ),
        ),
        Button(
          onPressed: () => _showComingSoonDialog(context, 'Print'),
          child: const Row(
            children: [
              Icon(FluentIcons.print),
              SizedBox(width: 8),
              Text('Print'),
            ],
          ),
        ),
        Button(
          onPressed: () => _showComingSoonDialog(context, 'Schedule'),
          child: const Row(
            children: [
              Icon(FluentIcons.calendar),
              SizedBox(width: 8),
              Text('Schedule'),
            ],
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
                if (value != null) {
                  setState(() {
                    _selectedReportType = value;
                  });
                }
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

class _ReportsContent extends StatelessWidget {
  final List reports;
  final Function(String) onShowComingSoon;

  const _ReportsContent({
    required this.reports,
    required this.onShowComingSoon,
  });

  @override
  Widget build(BuildContext context) {
    final fakerService = FakerService();

    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: _buildReportsList(context, fakerService)),
          const SizedBox(width: 16),
          Expanded(flex: 2, child: _buildAnalyticsPanel(context)),
        ],
      ),
    );
  }

  Widget _buildReportsList(BuildContext context, FakerService fakerService) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Recent Reports',
                  style: FluentTheme.of(context).typography.subtitle,
                ),
                const Spacer(),
                const Text('Last 30 days'),
              ],
            ),
            const SizedBox(height: 16),
            // Removemos el Expanded aquí y usamos un Container con altura fija
            Container(
              height: 400, // Altura fija para evitar problemas de layout
              child: reports.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FluentIcons.report_document, size: 48),
                          SizedBox(height: 16),
                          Text('No reports found'),
                        ],
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: reports.length,
                      itemBuilder: (context, index) {
                        final report = reports[index];
                        return Container(
                          decoration: BoxDecoration(
                            border: index < reports.length - 1
                                ? Border(
                                    bottom: BorderSide(color: Colors.grey[30]),
                                  )
                                : null,
                          ),
                          child: ListTile(
                            leading: _getReportIcon(report.type),
                            title: Text(report.title),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Generated by ${report.generatedBy.name}'),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    _ReportStatusChip(status: report.status),
                                    const SizedBox(width: 8),
                                    Icon(
                                      FluentIcons.clock,
                                      size: 12,
                                      color: Colors.grey[100],
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      fakerService.timeAgo(report.createdAt),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _ReportMetricChip(
                                  icon: FluentIcons.checkbox_composite,
                                  value: '${report.metrics['completion']}%',
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  icon: const Icon(
                                    FluentIcons.download,
                                    size: 16,
                                  ),
                                  onPressed: () =>
                                      onShowComingSoon('Download Report'),
                                ),
                                IconButton(
                                  icon: const Icon(FluentIcons.more, size: 16),
                                  onPressed: () =>
                                      _showReportActions(context, report),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsPanel(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Report Analytics',
                  style: FluentTheme.of(context).typography.subtitle,
                ),
                const SizedBox(height: 16),
                _AnalyticsItem(
                  label: 'Total Reports Generated',
                  value: '24',
                  change: '+12%',
                  isPositive: true,
                  icon: FluentIcons.report_document,
                  color: Colors.blue,
                ),
                _AnalyticsItem(
                  label: 'Completion Rate',
                  value: '92%',
                  change: '+5%',
                  isPositive: true,
                  icon: FluentIcons.check_mark,
                  color: Colors.green,
                ),
                _AnalyticsItem(
                  label: 'Average Processing Time',
                  value: '4.2min',
                  change: '-1.3min',
                  isPositive: true,
                  icon: FluentIcons.clock,
                  color: Colors.orange,
                ),
                _AnalyticsItem(
                  label: 'Data Accuracy',
                  value: '98.5%',
                  change: '+0.5%',
                  isPositive: true,
                  icon: FluentIcons.checkbox_composite,
                  color: Colors.purple,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Actions',
                  style: FluentTheme.of(context).typography.subtitle,
                ),
                const SizedBox(height: 16),
                _QuickActionButton(
                  icon: FluentIcons.bar_chart4,
                  label: 'View Dashboard',
                  onPressed: () => onShowComingSoon('View Dashboard'),
                ),
                _QuickActionButton(
                  icon: FluentIcons.data_flow,
                  label: 'Data Sources',
                  onPressed: () => onShowComingSoon('Data Sources'),
                ),
                _QuickActionButton(
                  icon: FluentIcons.settings,
                  label: 'Report Settings',
                  onPressed: () => onShowComingSoon('Report Settings'),
                ),
                _QuickActionButton(
                  icon: FluentIcons.help,
                  label: 'Help & Documentation',
                  onPressed: () => onShowComingSoon('Help & Documentation'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _getReportIcon(String type) {
    final icons = {
      'financial': FluentIcons.money,
      'performance': FluentIcons.speed_high,
      'audit': FluentIcons.security_group,
      'analytics': FluentIcons.bar_chart4,
      'compliance': FluentIcons.compliance_audit,
    };
    return CircleAvatar(
      backgroundColor: Colors.blue.withValues(alpha: 10),
      child: Icon(
        icons[type] ?? FluentIcons.report_document,
        size: 20,
        color: Colors.blue,
      ),
    );
  }

  void _showReportActions(BuildContext context, report) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: Text('Report Actions - ${report.title}'),
        content: const Text('Select an action for this report'),
        actions: [
          Button(
            child: const Text('View Details'),
            onPressed: () => Navigator.pop(context),
          ),
          Button(
            child: const Text('Export'),
            onPressed: () {
              Navigator.pop(context);
              onShowComingSoon('Export Report');
            },
          ),
          Button(
            child: const Text('Share'),
            onPressed: () => Navigator.pop(context),
          ),
          Button(
            child: const Text('Delete'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

class _ReportStatusChip extends StatelessWidget {
  final String status;

  const _ReportStatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final statusConfig = {
      'completed': {'color': Colors.green, 'label': 'Completed'},
      'in_progress': {'color': Colors.blue, 'label': 'In Progress'},
      'draft': {'color': Colors.orange, 'label': 'Draft'},
      'published': {'color': Colors.purple, 'label': 'Published'},
    };

    final config =
        statusConfig[status] ?? {'color': Colors.grey, 'label': status};

    return Container(
      decoration: BoxDecoration(
        color: (config['color'] as Color).withValues(alpha: 10),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        config['label'] as String,
        style: TextStyle(
          fontSize: 11,
          color: config['color'] as Color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _ReportMetricChip extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color;

  const _ReportMetricChip({
    required this.icon,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 10),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: color),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnalyticsItem extends StatelessWidget {
  final String label;
  final String value;
  final String change;
  final bool isPositive;
  final IconData icon;
  final Color color;

  const _AnalyticsItem({
    required this.label,
    required this.value,
    required this.change,
    required this.isPositive,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withValues(alpha: 10),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      value,
                      style: FluentTheme.of(context).typography.subtitle,
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: isPositive
                            ? Colors.green.withValues(alpha: 10)
                            : Colors.red.withValues(alpha: 10),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isPositive
                                ? FluentIcons.arrow_up_right
                                : FluentIcons.arrow_down_right8,
                            size: 10,
                            color: isPositive ? Colors.green : Colors.red,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            change,
                            style: TextStyle(
                              fontSize: 10,
                              color: isPositive ? Colors.green : Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: FilledButton(
        onPressed: onPressed,
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
}
