import 'package:go_router/go_router.dart';
import '../screens/dashboard_screen.dart';
import '../screens/users_screen.dart';
import '../screens/user_detail_screen.dart';
import '../screens/companies_screen.dart';
import '../screens/reports_screen.dart';
import '../screens/settings_screen.dart';

final router = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    GoRoute(path: '/', redirect: (context, state) => '/dashboard'),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(path: '/users', builder: (context, state) => const UsersScreen()),
    GoRoute(
      path: '/users/:id',
      builder: (context, state) =>
          UserDetailScreen(userId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/companies',
      builder: (context, state) => const CompaniesScreen(),
    ),
    GoRoute(
      path: '/reports',
      builder: (context, state) => const ReportsScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
