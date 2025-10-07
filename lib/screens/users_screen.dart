import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/search_box.dart';

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
              _buildActionBar(context),
              const SizedBox(height: 16),
              Expanded(
                child: dashboardProvider.isLoading
                    ? const Center(child: ProgressRing())
                    : _UsersTable(users: filteredUsers),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildActionBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchBox(
            placeholder: 'Search users by name, email or role...',
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ),
        const SizedBox(width: 16),
        FilledButton(
          onPressed: () => _showComingSoonDialog(context, 'Add User'),
          child: const Row(
            children: [
              Icon(FluentIcons.add),
              SizedBox(width: 8),
              Text('Add User'),
            ],
          ),
        ),
      ],
    );
  }

  void _showComingSoonDialog(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: Text(feature),
        content: Text('$feature feature coming soon.'),
        actions: [
          Button(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

class _UsersTable extends StatelessWidget {
  final List users;

  const _UsersTable({required this.users});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Users List',
                  style: FluentTheme.of(context).typography.subtitle,
                ),
                const Spacer(),
                Text('Total: ${users.length} users'),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: users.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FluentIcons.search, size: 48),
                          SizedBox(height: 16),
                          Text('No users found'),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return Container(
                          decoration: BoxDecoration(
                            border: index < users.length - 1
                                ? Border(
                                    bottom: BorderSide(color: Colors.grey[30]),
                                  )
                                : null,
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                user.name.substring(0, 2).toUpperCase(),
                              ),
                            ),
                            title: Text(user.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(user.email),
                                const SizedBox(height: 4),
                                Container(
                                  decoration: BoxDecoration(
                                    color: _getRoleColor(
                                      user.role,
                                    ).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  child: Text(
                                    user.role,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _getRoleColor(user.role),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(FluentIcons.edit, size: 16),
                                  onPressed: () =>
                                      _viewUserDetails(context, user.id),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    FluentIcons.delete,
                                    size: 16,
                                  ),
                                  onPressed: () =>
                                      _showDeleteDialog(context, user),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return Colors.red;
      case 'manager':
        return Colors.orange;
      case 'user':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  void _viewUserDetails(BuildContext context, String userId) {
    context.go('/users/$userId');
  }

  void _showDeleteDialog(BuildContext context, user) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Delete User'),
        content: Text('Are you sure you want to delete ${user.name}?'),
        actions: [
          Button(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          Button(
            child: const Text('Delete'),
            onPressed: () {
              Navigator.pop(context);
              _showComingSoonDialog(context, 'Delete User');
            },
          ),
        ],
      ),
    );
  }

  void _showComingSoonDialog(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: Text(feature),
        content: Text('$feature feature coming soon.'),
        actions: [
          Button(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
