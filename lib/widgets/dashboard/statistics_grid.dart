import 'package:fluent_ui/fluent_ui.dart';
import '../../providers/dashboard_provider.dart';
import '../../core/data/faker_service.dart';
import '../../widgets/stat_card.dart';

class StatisticsGrid extends StatelessWidget {
  final DashboardProvider provider;

  const StatisticsGrid({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    final fakerService = FakerService();

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        StatCard(
          title: 'Total Users',
          value: '${provider.stats['totalUsers'] ?? '0'}',
          icon: FluentIcons.people,
          color: Colors.blue,
        ),
        StatCard(
          title: 'Total Companies',
          value: '${provider.stats['totalCompanies'] ?? '0'}',
          icon: FluentIcons.business_card,
          color: Colors.green,
        ),
        StatCard(
          title: 'Active Reports',
          value: '${provider.stats['activeReports'] ?? '0'}',
          icon: FluentIcons.report_document,
          color: Colors.orange,
        ),
        StatCard(
          title: 'Pending Tasks',
          value: '${provider.stats['pendingTasks'] ?? '0'}',
          icon: FluentIcons.checkbox_composite,
          color: Colors.purple,
        ),
        StatCard(
          title: 'Total Revenue',
          value: fakerService.formatCurrency(
            provider.stats['revenue']?.toDouble() ?? 0.0,
          ),
          icon: FluentIcons.money,
          color: Colors.teal,
        ),
        StatCard(
          title: 'Active Users',
          value: '${provider.stats['activeUsers'] ?? '0'}',
          icon: FluentIcons.contact,
          color: Colors.yellow,
        ),
      ],
    );
  }
}
