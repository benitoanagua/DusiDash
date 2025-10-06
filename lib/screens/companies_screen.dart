import 'package:fluent_ui/fluent_ui.dart';

class CompaniesScreen extends StatelessWidget {
  const CompaniesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(title: Text('Companies Management')),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextBox(
                    placeholder: 'Search companies...',
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
                      Text('Add Company'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(child: _CompaniesTable()),
          ],
        ),
      ),
    );
  }
}

class _CompaniesTable extends StatelessWidget {
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
                  'Companies List',
                  style: FluentTheme.of(context).typography.subtitle,
                ),
                const Spacer(),
                const Text('Total: 567 companies'),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Icon(FluentIcons.offline_one_drive_parachute),
                    ),
                    title: Text('Company ${index + 1}'),
                    subtitle: Text('Industry ${index + 1}'),
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
