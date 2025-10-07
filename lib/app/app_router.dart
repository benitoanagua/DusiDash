import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../layouts/auth_layout.dart';
import '../layouts/non_auth_layout.dart';
import '../screens/dashboard_screen.dart';
import '../screens/users_screen.dart';
import '../screens/user_detail_screen.dart';
import '../screens/companies_screen.dart';
import '../screens/reports_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/login_screen.dart';
import 'route_paths.dart';

class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: RoutePaths.login,
      redirect: (context, state) {
        final authProvider = context.read<AuthProvider>();
        final isAuthenticated = authProvider.isAuthenticated;
        final isGoingToLogin = state.uri.path == RoutePaths.login;

        if (!isAuthenticated && !isGoingToLogin) {
          return RoutePaths.login;
        }

        if (isAuthenticated && isGoingToLogin) {
          return RoutePaths.dashboard;
        }

        return null;
      },
      errorBuilder: (context, state) => ScaffoldPage(
        header: const PageHeader(title: Text('Error')),
        content: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(FluentIcons.error, size: 64),
              const SizedBox(height: 16),
              Text(
                'Página no encontrada',
                style: FluentTheme.of(context).typography.title,
              ),
              const SizedBox(height: 8),
              Button(
                child: const Text('Volver al Inicio'),
                onPressed: () => context.go(RoutePaths.dashboard),
              ),
            ],
          ),
        ),
      ),
      routes: [
        GoRoute(
          path: RoutePaths.login,
          name: RouteNames.login,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const NonAuthLayout(child: LoginScreen()),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
            );
          },
        ),

        // ShellRoute para el layout autenticado
        ShellRoute(
          builder: (context, state, child) {
            return AuthLayout(child: child);
          },
          routes: [
            GoRoute(
              path: RoutePaths.dashboard,
              name: RouteNames.dashboard,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  key: state.pageKey,
                  child: const DashboardScreen(),
                );
              },
            ),

            GoRoute(
              path: RoutePaths.users,
              name: RouteNames.users,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  key: state.pageKey,
                  child: const UsersScreen(),
                );
              },
              routes: [
                GoRoute(
                  path: ':userId',
                  name: RouteNames.userDetail,
                  pageBuilder: (context, state) {
                    final userId = state.pathParameters['userId']!;
                    return NoTransitionPage(
                      key: state.pageKey,
                      child: UserDetailScreen(userId: userId),
                    );
                  },
                ),
              ],
            ),

            GoRoute(
              path: RoutePaths.companies,
              name: RouteNames.companies,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  key: state.pageKey,
                  child: const CompaniesScreen(),
                );
              },
            ),

            GoRoute(
              path: RoutePaths.reports,
              name: RouteNames.reports,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  key: state.pageKey,
                  child: const ReportsScreen(),
                );
              },
            ),

            GoRoute(
              path: RoutePaths.settings,
              name: RouteNames.settings,
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
  }
}
