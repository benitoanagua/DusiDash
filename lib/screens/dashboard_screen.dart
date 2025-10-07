import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/dashboard/statistics_grid.dart';
import '../widgets/dashboard/metrics_panel.dart';
import '../widgets/dashboard/quick_actions_panel.dart';
import '../widgets/dashboard/top_companies_list.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: const PageHeader(title: Text('Dashboard Overview')),
      content: Consumer<DashboardProvider>(
        builder: (context, dashboardProvider, child) {
          if (dashboardProvider.isLoading) {
            return const _LoadingState();
          }

          return _DashboardContent(provider: dashboardProvider);
        },
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
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
}

class _DashboardContent extends StatelessWidget {
  final DashboardProvider provider;

  const _DashboardContent({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatisticsGrid(provider: provider),
        const SizedBox(height: 24),
        Expanded(child: _DashboardLayout(provider: provider)),
      ],
    );
  }
}

class _DashboardLayout extends StatelessWidget {
  final DashboardProvider provider;

  const _DashboardLayout({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: MetricsPanel(provider: provider)),
        const SizedBox(width: 16),
        Expanded(flex: 1, child: _SidePanel(provider: provider)),
      ],
    );
  }
}

class _SidePanel extends StatelessWidget {
  final DashboardProvider provider;

  const _SidePanel({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const QuickActionsPanel(),
        const SizedBox(height: 16),
        TopCompaniesList(provider: provider),
      ],
    );
  }
}
