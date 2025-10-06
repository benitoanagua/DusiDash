import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../widgets/stat_card.dart';
import '../providers/dashboard_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: const PageHeader(title: Text('Dashboard Overview')),
      content: Consumer<DashboardProvider>(
        builder: (context, dashboardProvider, child) {
          if (dashboardProvider.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProgressRing(),
                  SizedBox(height: 16),
                  Text('Loading dashboard...'),
                ],
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Estadísticas principales
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  StatCard(
                    title: 'Total Users',
                    value: '${dashboardProvider.stats['totalUsers'] ?? '0'}',
                    icon: FluentIcons.people,
                    color: Colors.blue,
                  ),
                  StatCard(
                    title: 'Total Companies',
                    value:
                        '${dashboardProvider.stats['totalCompanies'] ?? '0'}',
                    icon: FluentIcons.business_card,
                    color: Colors.green,
                  ),
                  StatCard(
                    title: 'Active Reports',
                    value: '${dashboardProvider.stats['activeReports'] ?? '0'}',
                    icon: FluentIcons.report_document,
                    color: Colors.orange,
                  ),
                  StatCard(
                    title: 'Pending Tasks',
                    value: '${dashboardProvider.stats['pendingTasks'] ?? '0'}',
                    icon: FluentIcons.checkbox_composite,
                    color: Colors.purple,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Contenido adicional
              Expanded(child: _DashboardContent(provider: dashboardProvider)),
            ],
          );
        },
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  final DashboardProvider provider;

  const _DashboardContent({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Métricas de performance
        Expanded(
          flex: 2,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Performance Metrics',
                    style: FluentTheme.of(context).typography.subtitle,
                  ),
                  const SizedBox(height: 16),
                  ..._buildMetrics(context),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),

        // Acciones rápidas
        Expanded(
          flex: 1,
          child: Card(
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
                  ..._buildQuickActions(context),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildMetrics(BuildContext context) {
    final metrics = provider.metrics;
    return [
      _buildMetricItem(
        'User Growth',
        metrics['userGrowth'] ?? '15%',
        Colors.green,
      ),
      _buildMetricItem(
        'Revenue Growth',
        metrics['revenueGrowth'] ?? '12%',
        Colors.blue,
      ),
      _buildMetricItem(
        'Engagement Rate',
        metrics['engagementRate'] ?? '75%',
        Colors.orange,
      ),
      _buildMetricItem(
        'Conversion Rate',
        metrics['conversionRate'] ?? '8%',
        Colors.purple,
      ),
    ];
  }

  Widget _buildMetricItem(String title, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(child: Text(title, style: const TextStyle(fontSize: 14))),
          Container(
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                value,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildQuickActions(BuildContext context) {
    return [
      _QuickActionButton(
        icon: FluentIcons.add,
        label: 'Add User',
        onPressed: () => _showComingSoonDialog(context, 'Add User'),
      ),
      _QuickActionButton(
        icon: FluentIcons.report_document,
        label: 'Generate Report',
        onPressed: () => _showComingSoonDialog(context, 'Generate Report'),
      ),
      _QuickActionButton(
        icon: FluentIcons.bar_chart4,
        label: 'View Analytics',
        onPressed: () => _showComingSoonDialog(context, 'View Analytics'),
      ),
      _QuickActionButton(
        icon: FluentIcons.download,
        label: 'Export Data',
        onPressed: () => _showComingSoonDialog(context, 'Export Data'),
      ),
    ];
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
