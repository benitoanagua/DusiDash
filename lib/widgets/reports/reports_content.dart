import 'package:fluent_ui/fluent_ui.dart';
import 'reports_list.dart';
import 'analytics_panel.dart';

class ReportsContent extends StatelessWidget {
  final List reports;
  final String selectedReportType;
  final ValueChanged<String>? onReportTypeChanged;
  final Function(String) onShowComingSoon;

  const ReportsContent({
    super.key,
    required this.reports,
    required this.selectedReportType,
    this.onReportTypeChanged,
    required this.onShowComingSoon,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: _buildReportsList()),
          const SizedBox(width: 16),
          Expanded(flex: 2, child: _buildAnalyticsPanel()),
        ],
      ),
    );
  }

  Widget _buildReportsList() {
    return ReportsList(reports: reports, onShowComingSoon: onShowComingSoon);
  }

  Widget _buildAnalyticsPanel() {
    return AnalyticsPanel(onShowComingSoon: onShowComingSoon);
  }
}
