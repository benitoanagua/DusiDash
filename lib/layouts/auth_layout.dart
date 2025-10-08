import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/theme_provider.dart';
import '../providers/auth_provider.dart';
import '../app/route_paths.dart';

class AuthLayout extends StatefulWidget {
  final Widget child;

  const AuthLayout({super.key, required this.child});

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  int selectedNavigation = 0;

  @override
  void initState() {
    super.initState();
    _loadSelectedNavigation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncSelectedIndexWithRoute();
    });
  }

  Future<void> _loadSelectedNavigation() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedNavigation = prefs.getInt('selectedNavigation') ?? 0;
    });
  }

  Future<void> _saveSelectedNavigation(int index) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedNavigation', index);
  }

  final Map<String, int> _routeToIndex = {
    RoutePaths.dashboard: 0,
    RoutePaths.users: 1,
    RoutePaths.companies: 2,
    RoutePaths.reports: 3,
    RoutePaths.settings: 4,
  };

  final List<NavigationPaneItem> _items = [
    PaneItem(
      key: const ValueKey('/dashboard'),
      icon: const Icon(FluentIcons.view_dashboard),
      title: const Text('Dashboard'),
      body: const SizedBox.shrink(),
    ),
    PaneItem(
      key: const ValueKey('/users'),
      icon: const Icon(FluentIcons.people),
      title: const Text('Users'),
      body: const SizedBox.shrink(),
    ),
    PaneItem(
      key: const ValueKey('/companies'),
      icon: const Icon(FluentIcons.business_card),
      title: const Text('Companies'),
      body: const SizedBox.shrink(),
    ),
    PaneItem(
      key: const ValueKey('/reports'),
      icon: const Icon(FluentIcons.report_document),
      title: const Text('Reports'),
      infoBadge: const InfoBadge(source: Text('3')),
      body: const SizedBox.shrink(),
    ),
    PaneItemSeparator(),

    PaneItemExpander(
      key: const ValueKey('/analytics'),
      icon: const Icon(FluentIcons.bar_chart4),
      title: const Text('Analytics'),
      body: const _CustomBodyItem(
        title: 'Analytics Hub',
        content:
            'Explore detailed analytics and insights about your business performance, user engagement, and revenue metrics.',
      ),
      items: [
        PaneItemHeader(header: const Text('Performance')),
        PaneItem(
          icon: const Icon(FluentIcons.speed_high),
          title: const Text('Performance Metrics'),
          body: const _CustomBodyItem(
            title: 'Performance Metrics',
            content:
                'Track system performance, response times, and user engagement metrics.',
          ),
        ),
        PaneItem(
          icon: const Icon(FluentIcons.trending12),
          title: const Text('Growth Trends'),
          body: const _CustomBodyItem(
            title: 'Growth Trends',
            content:
                'Analyze user growth, revenue trends, and market expansion.',
          ),
        ),
        PaneItemHeader(header: const Text('User Analytics')),
        PaneItem(
          icon: const Icon(FluentIcons.user_gauge),
          title: const Text('User Behavior'),
          body: const _CustomBodyItem(
            title: 'User Behavior',
            content:
                'Understand how users interact with your platform and features.',
          ),
        ),
      ],
    ),

    PaneItem(
      key: const ValueKey('/notifications'),
      icon: const Icon(FluentIcons.ringer),
      title: const Text('Notifications'),
      infoBadge: const InfoBadge(source: Text('12+')),
      body: const _CustomBodyItem(
        title: 'Notifications Center',
        content: 'Manage your notification preferences and view recent alerts.',
      ),
    ),

    PaneItem(
      key: const ValueKey('/premium'),
      icon: const Icon(FluentIcons.diamond),
      title: const Text('Premium Features'),
      body: const _CustomBodyItem(
        title: 'Premium Features',
        content: 'Upgrade to access advanced features and analytics.',
      ),
      enabled: false,
    ),

    PaneItemSeparator(),
    PaneItem(
      key: const ValueKey('/settings'),
      icon: const Icon(FluentIcons.settings),
      title: const Text('Settings'),
      body: const SizedBox.shrink(),
    ),

    PaneItemWidgetAdapter(
      key: const ValueKey('/custom_widget'),
      child: Builder(
        builder: (context) {
          final displayMode = NavigationView.of(context).displayMode;

          if (displayMode == PaneDisplayMode.compact) {
            return const Tooltip(
              message: 'Quick Actions',
              child: Icon(FluentIcons.lightning_bolt),
            );
          }

          return ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 200.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: const Row(
                children: [
                  Icon(FluentIcons.lightning_bolt, size: 16),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      'Quick Actions',
                      style: TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  ];

  final List<String> _routes = [
    RoutePaths.dashboard,
    RoutePaths.users,
    RoutePaths.companies,
    RoutePaths.reports,
    RoutePaths.settings,
  ];

  void _syncSelectedIndexWithRoute() {
    final currentLocation = GoRouterState.of(context).uri.path;

    int? newIndex;

    newIndex = _routeToIndex[currentLocation];

    if (newIndex == null && currentLocation.startsWith(RoutePaths.users)) {
      newIndex = _routeToIndex[RoutePaths.users];
    }

    if (newIndex != null && newIndex != selectedNavigation) {
      setState(() {
        selectedNavigation = newIndex!;
      });
      _saveSelectedNavigation(newIndex);
    }
  }

  void _handleNavigation(int index) {
    if (index < _routes.length) {
      setState(() {
        selectedNavigation = index;
      });
      _saveSelectedNavigation(index);
      context.go(_routes[index]);
    } else {
      setState(() {
        selectedNavigation = index;
      });
      _saveSelectedNavigation(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return NavigationView(
      appBar: NavigationAppBar(
        title: Text(
          'Dusi Dash',
          style: FluentTheme.of(context).typography.title,
        ),
        actions: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsetsDirectional.only(end: 16.0),
          child: ToggleSwitch(
            content: const Text('Dark Mode'),
            checked: themeProvider.isDark,
            onChanged: (bool v) {
              themeProvider.toggleTheme();
            },
          ),
        ),
      ),
      paneBodyBuilder: (item, body) {
        return widget.child;
      },
      pane: NavigationPane(
        size: const NavigationPaneSize(openWidth: 240),
        selected: selectedNavigation,
        onChanged: _handleNavigation,
        displayMode: PaneDisplayMode.auto,
        items: _items,
        footerItems: [
          PaneItem(
            key: const ValueKey('/profile'),
            icon: const Icon(FluentIcons.contact),
            title: const Text('Profile'),
            body: const _CustomBodyItem(
              title: 'User Profile',
              content: 'Manage your personal information and account settings.',
            ),
          ),
          PaneItemAction(
            key: const ValueKey('add_feature'),
            icon: const Icon(FluentIcons.add),
            title: const Text('Add Feature'),
            onTap: () {
              _showAddFeatureDialog(context);
            },
          ),
          PaneItemAction(
            key: const ValueKey('sign_out'),
            icon: const Icon(FluentIcons.sign_out),
            title: Text(
              'Sign Out - ${authProvider.currentUser?.name.split(' ').first ?? 'User'}',
            ),
            onTap: () {
              authProvider.logout();
              context.go(RoutePaths.login);
            },
          ),
        ],
        header: const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: SizedBox(height: 56, child: FlutterLogo(size: 56)),
        ),
      ),
    );
  }

  void _showAddFeatureDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Add New Feature'),
        content: const Text(
          'This demonstrates how you can add dynamic features to your navigation.',
        ),
        actions: [
          Button(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          FilledButton(
            child: const Text('Add'),
            onPressed: () {
              Navigator.pop(context);
              _showFeatureAddedMessage(context);
            },
          ),
        ],
      ),
    );
  }

  void _showFeatureAddedMessage(BuildContext context) {
    displayInfoBar(
      context,
      builder: (context, close) => InfoBar(
        title: const Text('Feature Added'),
        content: const Text('New feature has been added to your navigation.'),
        severity: InfoBarSeverity.success,
        action: IconButton(
          icon: const Icon(FluentIcons.clear),
          onPressed: close,
        ),
      ),
    );
  }
}

class _CustomBodyItem extends StatelessWidget {
  final String title;
  final String content;

  const _CustomBodyItem({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: PageHeader(title: Text(title)),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: FluentTheme.of(context).typography.title),
                  const SizedBox(height: 16),
                  Text(content, style: FluentTheme.of(context).typography.body),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () {
                      displayInfoBar(
                        context,
                        builder: (context, close) => InfoBar(
                          title: Text('$title Feature'),
                          content: const Text(
                            'This feature is currently in development.',
                          ),
                          severity: InfoBarSeverity.info,
                          action: IconButton(
                            icon: const Icon(FluentIcons.clear),
                            onPressed: close,
                          ),
                        ),
                      );
                    },
                    child: const Text('Explore Feature'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
