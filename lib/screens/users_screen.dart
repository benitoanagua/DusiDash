import 'package:fluent_ui/fluent_ui.dart';
import '../widgets/search_box.dart';

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
                  child: SearchBox(
                    placeholder: 'Search users...',
                    onChanged: (value) {},
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
                const SizedBox(width: 8),
                Button(
                  onPressed: () {},
                  child: const Row(
                    children: [
                      Icon(FluentIcons.upload),
                      SizedBox(width: 8),
                      Text('Import'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Wrap(
              spacing: 8,
              children: [
                _buildFilterChip('All Users', true),
                _buildFilterChip('Active', false),
                _buildFilterChip('Inactive', false),
                _buildFilterChip('Admins', false),
              ],
            ),
            const SizedBox(height: 16),

            Expanded(child: _UsersTable()),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String text, bool selected) {
    return Container(
      decoration: BoxDecoration(
        color: selected ? Colors.blue : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: selected ? Colors.blue : Colors.grey[30]),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Text(
          text,
          style: TextStyle(color: selected ? Colors.white : Colors.grey[100]),
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
                  return Container(
                    decoration: BoxDecoration(
                      border: index < 19
                          ? Border(bottom: BorderSide(color: Colors.grey[30]))
                          : null,
                    ),
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(FluentIcons.people),
                      ),
                      title: Text('User ${index + 1}'),
                      subtitle: Text('user${index + 1}@example.com'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(FluentIcons.edit, size: 16),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(FluentIcons.delete, size: 16),
                            onPressed: () {},
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
}
