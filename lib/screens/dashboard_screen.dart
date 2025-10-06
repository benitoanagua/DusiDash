import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../widgets/stat_card.dart';
import '../providers/theme_provider.dart';
import '../providers/dashboard_provider.dart';
import 'users_screen.dart';
import 'companies_screen.dart';
import 'reports_screen.dart';
import 'settings_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardContent(),
    const UsersScreen(),
    const CompaniesScreen(),
    const ReportsScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dashboardProvider = Provider.of<DashboardProvider>(
        context,
        listen: false,
      );
      dashboardProvider.loadDashboardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        title: const Text('Dusi Dash'),
        actions: Row(
          children: [
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return ToggleSwitch(
                  checked: themeProvider.isDark,
                  onChanged: (value) {
                    themeProvider.toggleTheme();
                  },
                  content: const Text('Dark Mode'),
                );
              },
            ),
          ],
        ),
      ),
      pane: NavigationPane(
        selected: _selectedIndex,
        onChanged: (index) => setState(() => _selectedIndex = index),
        displayMode: PaneDisplayMode.auto,
        size: const NavigationPaneSize(openWidth: 250),
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.view_dashboard),
            title: const Text('Dashboard'),
            body: _screens[_selectedIndex],
          ),
          PaneItem(
            icon: const Icon(FluentIcons.people),
            title: const Text('Users'),
            body: _screens[_selectedIndex],
          ),
          PaneItem(
            icon: const Icon(FluentIcons.business_card),
            title: const Text('Companies'),
            body: _screens[_selectedIndex],
          ),
          PaneItem(
            icon: const Icon(FluentIcons.report_document),
            title: const Text('Reports'),
            body: _screens[_selectedIndex],
          ),
        ],
        footerItems: [
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
            body: _screens[_selectedIndex],
          ),
        ],
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = context.watch<DashboardProvider>();

    if (dashboardProvider.isLoading) {
      return const ScaffoldPage(
        content: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProgressRing(),
              SizedBox(height: 16),
              Text('Loading dashboard...'),
            ],
          ),
        ),
      );
    }

    return ScaffoldPage(
      header: const PageHeader(title: Text('Dashboard Overview')),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  value: '${dashboardProvider.stats['totalCompanies'] ?? '0'}',
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

            Row(
              children: [
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
                          _buildMetricItem('User Growth', '+12%', Colors.green),
                          _buildMetricItem(
                            'Revenue Growth',
                            '+8%',
                            Colors.blue,
                          ),
                          _buildMetricItem(
                            'Engagement Rate',
                            '+15%',
                            Colors.orange,
                          ),
                          _buildMetricItem(
                            'Conversion Rate',
                            '+5%',
                            Colors.purple,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
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
            ),
            const SizedBox(height: 24),

            Expanded(
              child: _RecentActivityTable(users: dashboardProvider.users),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricItem(String title, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(child: Text(title, style: const TextStyle(fontSize: 14))),
          Container(
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
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
        onPressed: () {},
      ),
      _QuickActionButton(
        icon: FluentIcons.report_document,
        label: 'Generate Report',
        onPressed: () {},
      ),
      _QuickActionButton(
        icon: FluentIcons.bar_chart4,
        label: 'View Analytics',
        onPressed: () {},
      ),
      _QuickActionButton(
        icon: FluentIcons.download,
        label: 'Export Data',
        onPressed: () {},
      ),
    ];
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

class _RecentActivityTable extends StatelessWidget {
  final List<dynamic> users;

  const _RecentActivityTable({required this.users});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Recent User Activity',
                  style: FluentTheme.of(context).typography.subtitle,
                ),
                const Spacer(),

                const SizedBox(width: 8),
                Button(onPressed: () {}, child: const Text('View All')),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: users.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FluentIcons.inbox, size: 48, color: Colors.grey),
                          SizedBox(height: 16),
                          Text('No users found'),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return Container(
                          decoration: BoxDecoration(
                            border: index < users.length - 1
                                ? Border(
                                    bottom: BorderSide(color: Colors.grey[30]!),
                                  )
                                : null,
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: _getUserColor(index),
                              child: Icon(
                                _getUserIcon(index),
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            title: Text(user.name ?? 'User ${index + 1}'),
                            subtitle: Text(
                              user.email ?? 'user${index + 1}@example.com',
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(width: 8),
                                Text(
                                  '${index + 1}d ago',
                                  style: TextStyle(
                                    color: Colors.grey[60],
                                    fontSize: 12,
                                  ),
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

  Color _getUserColor(int index) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
    ];
    return colors[index % colors.length];
  }

  IconData _getUserIcon(int index) {
    final icons = [
      FluentIcons.people,
      FluentIcons.contact,
      FluentIcons.user_followed,
      FluentIcons.contact_card,
      FluentIcons.accounts,
    ];
    return icons[index % icons.length];
  }
}
