import 'package:fluent_ui/fluent_ui.dart';

class CompaniesScreen extends StatelessWidget {
  const CompaniesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: const PageHeader(title: Text('Companies Management')),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildActionBar(context),
          const SizedBox(height: 16),
          Expanded(child: _CompaniesTable()),
        ],
      ),
    );
  }

  Widget _buildActionBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextBox(
            placeholder: 'Search companies...',
            prefix: const Icon(FluentIcons.search, size: 16),
          ),
        ),
        const SizedBox(width: 16),
        FilledButton(
          onPressed: () => _showComingSoonDialog(context, 'Add Company'),
          child: const Row(
            children: [
              Icon(FluentIcons.add),
              SizedBox(width: 8),
              Text('Add Company'),
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
                    leading: const CircleAvatar(
                      child: Icon(FluentIcons.business_card),
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
