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
      body: const SizedBox.shrink(),
    ),
    PaneItemSeparator(),
    PaneItem(
      key: const ValueKey('/settings'),
      icon: const Icon(FluentIcons.settings),
      title: const Text('Settings'),
      body: const SizedBox.shrink(),
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
            body: const SizedBox.shrink(),
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
}
