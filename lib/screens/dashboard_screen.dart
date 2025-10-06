import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../widgets/stat_card.dart';
import '../providers/theme_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        title: const Text('Dashboard'),
        actions: ToggleSwitch(
          checked: context.watch<ThemeProvider>().isDark,
          onChanged: (value) {
            context.read<ThemeProvider>().toggleTheme();
          },
          content: const Text('Dark Mode'),
        ),
      ),
      pane: NavigationPane(
        selected: _selectedIndex,
        onChanged: (index) => setState(() => _selectedIndex = index),
        displayMode: PaneDisplayMode.auto,
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.view_dashboard),
            title: const Text('Dashboard'),
            body: const SizedBox(),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.people),
            title: const Text('Users'),
            body: const SizedBox(),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.business_card),
            title: const Text('Companies'),
            body: const SizedBox(),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.report_document),
            title: const Text('Reports'),
            body: const SizedBox(),
          ),
        ],
        footerItems: [
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
            body: const SizedBox(),
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
                  value: '1,234',
                  icon: FluentIcons.people,
                  color: Colors.blue,
                ),
                StatCard(
                  title: 'Total Companies',
                  value: '567',
                  icon: FluentIcons.business_card,
                  color: Colors.green,
                ),
                StatCard(
                  title: 'Active Reports',
                  value: '89',
                  icon: FluentIcons.report_document,
                  color: Colors.orange,
                ),
                StatCard(
                  title: 'Pending Tasks',
                  value: '23',
                  icon: FluentIcons.checkbox_composite,
                  color: Colors.purple,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(child: _RecentActivityTable()),
          ],
        ),
      ),
    );
  }
}

class _RecentActivityTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Activity',
              style: FluentTheme.of(context).typography.subtitle,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(FluentIcons.history),
                    title: Text('Activity ${index + 1}'),
                    subtitle: Text('Description of activity ${index + 1}'),
                    trailing: Text('${index + 1}h ago'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
