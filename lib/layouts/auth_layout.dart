import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
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
        title: const Text('Dusi Dash'),
        actions: Row(
          children: [
            ToggleSwitch(
              checked: themeProvider.isDark,
              onChanged: (value) => themeProvider.toggleTheme(),
              content: const Text('Dark Mode'),
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
      ),
    );
  }
}
