import 'package:go_router/go_router.dart';
import '../screens/dashboard_screen.dart';

// Router simplificado por ahora
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const DashboardScreen()),
  ],
);
