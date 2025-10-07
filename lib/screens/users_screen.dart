import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/users/users_action_bar.dart';
import '../widgets/users/users_table.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: const PageHeader(title: Text('Users Management')),
      content: Consumer<DashboardProvider>(
        builder: (context, dashboardProvider, child) {
          final filteredUsers = _searchQuery.isEmpty
              ? dashboardProvider.users
              : dashboardProvider.users.where((user) {
                  return user.name.toLowerCase().contains(
                        _searchQuery.toLowerCase(),
                      ) ||
                      user.email.toLowerCase().contains(
                        _searchQuery.toLowerCase(),
                      ) ||
                      user.role.toLowerCase().contains(
                        _searchQuery.toLowerCase(),
                      );
                }).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UsersActionBar(
                onSearchChanged: (value) =>
                    setState(() => _searchQuery = value),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: dashboardProvider.isLoading
                    ? const Center(child: ProgressRing())
                    : UsersTable(users: filteredUsers),
              ),
            ],
          );
        },
      ),
    );
  }
}
