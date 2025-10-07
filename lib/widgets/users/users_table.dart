import 'package:fluent_ui/fluent_ui.dart';
import 'user_table_row.dart';

class UsersTable extends StatelessWidget {
  final List users;

  const UsersTable({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _TableHeader(usersCount: users.length),
            const SizedBox(height: 16),
            Expanded(child: _UsersList(users: users)),
          ],
        ),
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  final int usersCount;

  const _TableHeader({required this.usersCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Users List', style: FluentTheme.of(context).typography.subtitle),
        const Spacer(),
        Text('Total: $usersCount users'),
      ],
    );
  }
}

class _UsersList extends StatelessWidget {
  final List users;

  const _UsersList({required this.users});

  @override
  Widget build(BuildContext context) {
    return users.isEmpty
        ? const _EmptyState()
        : ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return UserTableRow(user: user);
            },
          );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(FluentIcons.search, size: 48),
          SizedBox(height: 16),
          Text('No users found'),
        ],
      ),
    );
  }
}
