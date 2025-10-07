import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/theme_provider.dart';
import '../providers/auth_provider.dart';
import '../layouts/auth_layout.dart';
import '../layouts/non_auth_layout.dart';
import '../screens/dashboard_screen.dart';
import '../screens/users_screen.dart';
import '../screens/companies_screen.dart';
import '../screens/reports_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/login_screen.dart';
import '../screens/user_detail_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return FluentApp.router(
      title: 'Dusi Dash',
      themeMode: themeProvider.themeMode,
      theme: FluentThemeData(
        brightness: Brightness.light,
        accentColor: Colors.blue,
      ),
      darkTheme: FluentThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.blue,
      ),
      routerConfig: _router,
      locale: const Locale('es'),
      supportedLocales: const [Locale('en'), Locale('es')],
      debugShowCheckedModeBanner: false,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) {
    final authProvider = context.read<AuthProvider>();
    final isAuthenticated = authProvider.isAuthenticated;
    final isGoingToLogin = state.uri.path == '/login';

    if (!isAuthenticated && !isGoingToLogin) {
      return '/login';
    }

    if (isAuthenticated && isGoingToLogin) {
      return '/dashboard';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const NonAuthLayout(child: LoginScreen()),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    ),
    ShellRoute(
      builder: (context, state, child) {
        return AuthLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/dashboard',
          pageBuilder: (context, state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: const DashboardScreen(),
            );
          },
        ),
        GoRoute(
          path: '/users',
          pageBuilder: (context, state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: const UsersScreen(),
            );
          },
        ),
        GoRoute(
          path: '/users/:userId',
          pageBuilder: (context, state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: UserDetailScreen(userId: state.pathParameters['userId']!),
            );
          },
        ),
        GoRoute(
          path: '/companies',
          pageBuilder: (context, state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: const CompaniesScreen(),
            );
          },
        ),
        GoRoute(
          path: '/reports',
          pageBuilder: (context, state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: const ReportsScreen(),
            );
          },
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (context, state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: const SettingsScreen(),
            );
          },
        ),
      ],
    ),
  ],
);
