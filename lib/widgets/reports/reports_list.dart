import 'package:fluent_ui/fluent_ui.dart';

class ReportsList extends StatelessWidget {
  final List reports;
  final List<String> selectedReports;
  final ValueChanged<List<String>> onSelectionChanged;

  const ReportsList({
    super.key,
    required this.reports,
    required this.selectedReports,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(
              children: [
                Text(
                  'Reports',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Spacer(),
                Text('Recent'),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: reports.isEmpty
                  ? const _EmptyState()
                  : ListView.builder(
                      itemCount: reports.length,
                      itemBuilder: (context, index) {
                        final report = reports[index];
                        return _ReportItem(
                          report: report,
                          isSelected: selectedReports.contains(report.id),
                          onSelected: (selected) =>
                              _handleSelection(report.id, selected),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSelection(String reportId, bool selected) {
    final newSelection = List<String>.from(selectedReports);
    if (selected) {
      newSelection.add(reportId);
    } else {
      newSelection.remove(reportId);
    }
    onSelectionChanged(newSelection);
  }
}

class _ReportItem extends StatelessWidget {
  final dynamic report;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const _ReportItem({
    required this.report,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile.selectable(
      leading: CircleAvatar(
        backgroundColor: _getTypeColor(report.type),
        child: Icon(_getTypeIcon(report.type), size: 16, color: Colors.white),
      ),
      title: Text(report.title),
      subtitle: Text('${report.type} • ${report.generatedBy.name}'),
      trailing: _StatusChip(status: report.status),
      selected: isSelected,
      onSelectionChange: onSelected,
    );
  }

  Color _getTypeColor(String type) {
    final colors = {
      'financial': Colors.green,
      'performance': Colors.blue,
      'analytics': Colors.purple,
    };
    return colors[type] ?? Colors.grey;
  }

  IconData _getTypeIcon(String type) {
    final icons = {
      'financial': FluentIcons.money,
      'performance': FluentIcons.speed_high,
      'analytics': FluentIcons.bar_chart4,
    };
    return icons[type] ?? FluentIcons.report_document;
  }
}

class _StatusChip extends StatelessWidget {
  final String status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final color = status == 'completed'
        ? Colors.green
        : status == 'in_progress'
        ? Colors.blue
        : Colors.orange;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 10),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(FluentIcons.report_document, size: 48),
          SizedBox(height: 16),
          Text('No reports found'),
        ],
      ),
    );
  }
}
