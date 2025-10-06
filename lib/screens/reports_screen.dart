import 'package:fluent_ui/fluent_ui.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: const PageHeader(title: Text('Reports & Analytics')),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildActionBar(),
          const SizedBox(height: 24),
          Expanded(child: _ReportsContent()),
        ],
      ),
    );
  }

  Widget _buildActionBar() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        FilledButton(
          onPressed: () {},
          child: const Row(
            children: [
              Icon(FluentIcons.download),
              SizedBox(width: 8),
              Text('Export Report'),
            ],
          ),
        ),
        Button(
          onPressed: () {},
          child: const Row(
            children: [
              Icon(FluentIcons.print),
              SizedBox(width: 8),
              Text('Print Report'),
            ],
          ),
        ),
      ],
    );
  }
}

class _ReportsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Report Summary',
                    style: FluentTheme.of(context).typography.subtitle,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(FluentIcons.doc_library),
                          title: Text('Report ${index + 1}'),
                          subtitle: Text('Generated ${index + 1} days ago'),
                          trailing: const Icon(FluentIcons.download),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 1,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Actions',
                    style: FluentTheme.of(context).typography.subtitle,
                  ),
                  const SizedBox(height: 16),
                  ...[
                    'Daily Report',
                    'Weekly Summary',
                    'Monthly Analytics',
                    'Custom Report',
                  ].map(
                    (action) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: FilledButton(
                        onPressed: () {},
                        child: Text(action),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
