import 'package:fluent_ui/fluent_ui.dart';
import '../widgets/search_box.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: const PageHeader(title: Text('Users Management')),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Barra de búsqueda y acciones
          _buildActionBar(context),
          const SizedBox(height: 16),

          // Contenido principal
          Expanded(child: _UsersTable()),
        ],
      ),
    );
  }

  Widget _buildActionBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchBox(
            placeholder: 'Search users...',
            onChanged: (value) {},
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
