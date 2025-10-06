import 'package:fluent_ui/fluent_ui.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(title: Text('Users Management')),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextBox(
                    placeholder: 'Search users...',
                    prefix: const Icon(FluentIcons.search, size: 16),
                  ),
                ),
                const SizedBox(width: 16),
                FilledButton(
                  onPressed: () {},
                  child: const Row(
                    children: [
                      Icon(FluentIcons.add),
                      SizedBox(width: 8),
                      Text('Add User'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(child: _UsersTable()),
          ],
        ),
      ),
    );
  }
}

class _UsersTable extends StatelessWidget {
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
                const Text('Total: 1,234 users'),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      child: Icon(FluentIcons.people),
                    ),
                    title: Text('User ${index + 1}'),
                    subtitle: Text('user${index + 1}@example.com'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(FluentIcons.edit),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(FluentIcons.delete),
                          onPressed: () {},
                        ),
                      ],
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
}
