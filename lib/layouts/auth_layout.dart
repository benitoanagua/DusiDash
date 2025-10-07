import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/dashboard_provider.dart';
import '../screens/dashboard_screen.dart';
import '../screens/users_screen.dart';
import '../screens/companies_screen.dart';
import '../screens/reports_screen.dart';
import '../screens/settings_screen.dart';

class AuthLayout extends StatefulWidget {
  final Widget child;

  const AuthLayout({super.key, required this.child});

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  int _selectedIndex = 0;
  final _flyoutController = FlyoutController();

  final List<NavigationPaneItem> _items = [
    PaneItem(
      icon: const Icon(FluentIcons.view_dashboard),
      title: const Text('Dashboard'),
      body: const DashboardScreen(),
    ),
    PaneItem(
      icon: const Icon(FluentIcons.people),
      title: const Text('Users'),
      body: const UsersScreen(),
    ),
    PaneItem(
      icon: const Icon(FluentIcons.business_card),
      title: const Text('Companies'),
      body: const CompaniesScreen(),
    ),
    PaneItem(
      icon: const Icon(FluentIcons.report_document),
      title: const Text('Reports'),
      body: const ReportsScreen(),
    ),
    PaneItemSeparator(),
    PaneItem(
      icon: const Icon(FluentIcons.settings),
      title: const Text('Settings'),
      body: const SettingsScreen(),
    ),
  ];

  final List<String> _routes = [
    '/dashboard',
    '/users',
    '/companies',
    '/reports',
    '/settings',
  ];

  void _handleNavigation(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index < _routes.length) {
      context.go(_routes[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final dashboardProvider = Provider.of<DashboardProvider>(context);

    final currentLocation = GoRouterState.of(context).uri.path;
    final currentIndex = _routes.indexWhere(
      (route) => route == currentLocation,
    );

    if (currentIndex != -1 && currentIndex != _selectedIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _selectedIndex = currentIndex;
        });
      });
    }

    return NavigationView(
      appBar: NavigationAppBar(
        automaticallyImplyLeading: false,
        title: const Text('Dusi Dash'),
        actions: Row(
          children: [
            IconButton(
              icon: const Icon(FluentIcons.refresh),
              onPressed: () {
                dashboardProvider.refreshData();
              },
            ),
            const SizedBox(width: 8),
            ToggleSwitch(
              checked: themeProvider.isDark,
              onChanged: (value) => themeProvider.toggleTheme(),
              content: const Text('Dark Mode'),
            ),
            const SizedBox(width: 16),
            FlyoutTarget(
              controller: _flyoutController,
              child: IconButton(
                icon: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      child: Text(
                        authProvider.currentUser?.name
                                .substring(0, 2)
                                .toUpperCase() ??
                            'U',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      authProvider.currentUser?.name.split(' ').first ?? 'User',
                    ),
                    const Icon(FluentIcons.chevron_down),
                  ],
                ),
                onPressed: () {
                  _flyoutController.showFlyout(
                    builder: (context) {
                      return MenuFlyout(
                        items: [
                          MenuFlyoutItemBuilder(
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      authProvider.currentUser?.name ?? 'User',
                                      style: FluentTheme.of(
                                        context,
                                      ).typography.subtitle,
                                    ),
                                    Text(
                                      authProvider.currentUser?.email ?? '',
                                      style: TextStyle(color: Colors.grey[100]),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const MenuFlyoutSeparator(),
                          MenuFlyoutItem(
                            text: const Text('Profile Settings'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          MenuFlyoutItem(
                            text: const Text('Sign Out'),
                            onPressed: () {
                              authProvider.logout();
                              Navigator.of(context).pop();
                              context.go('/login');
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      pane: NavigationPane(
        selected: _selectedIndex,
        onChanged: _handleNavigation,
        displayMode: PaneDisplayMode.auto,
        size: const NavigationPaneSize(openWidth: 250),
        items: _items,
        footerItems: [
          PaneItem(
            icon: const Icon(FluentIcons.help),
            title: const Text('Help & Support'),
            body: const SizedBox(),
          ),
        ],
      ),
    );
  }
}
