import 'package:fluent_ui/fluent_ui.dart';
import '../../models/company.dart';
import '../../core/data/faker_service.dart';

class CompanyDetailsPanel extends StatelessWidget {
  final Company company;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CompanyDetailsPanel({
    super.key,
    required this.company,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final fakerService = FakerService();

    return Card(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(context),
            const SizedBox(height: 20),

            // Basic Info
            _buildSection(context, 'Company Information', [
              _buildInfoRow('Industry', company.industry),
              _buildInfoRow('Location', company.location),
              _buildInfoRow('Employees', '${company.employees}'),
              _buildInfoRow(
                'Founded',
                fakerService.formatDate(company.founded),
              ),
              _buildInfoRow(
                'Revenue',
                fakerService.formatCurrency(company.revenue),
              ),
              _buildInfoRow('Website', company.website),
            ]),
            const SizedBox(height: 20),

            // Description
            _buildSection(context, 'Description', [
              Text(
                company.description,
                style: FluentTheme.of(context).typography.body,
              ),
            ]),
            const SizedBox(height: 20),

            // Contact
            _buildSection(context, 'Contact Information', [
              _buildInfoRow('Email', company.contact.email),
              _buildInfoRow('Phone', company.contact.phone),
              _buildInfoRow('Address', company.contact.address),
            ]),
            const SizedBox(height: 20),

            // Tags
            _buildTagsSection(context),
            const SizedBox(height: 20),

            // Actions
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: _getIndustryColor(company.industry),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              company.name.substring(0, 2).toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                company.name,
                style: FluentTheme.of(context).typography.title,
              ),
              const SizedBox(height: 4),
              Text(
                company.industry,
                style: TextStyle(
                  color: _getIndustryColor(company.industry),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: FluentTheme.of(context).typography.subtitle),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildTagsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tags', style: FluentTheme.of(context).typography.subtitle),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: company.tags.map((tag) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 10),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                tag,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        FilledButton(
          onPressed: onEdit,
          child: const Row(
            children: [
              Icon(FluentIcons.edit, size: 16),
              SizedBox(width: 8),
              Text('Edit'),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Button(
          onPressed: () => _showShareDialog(context),
          child: const Row(
            children: [
              Icon(FluentIcons.share, size: 16),
              SizedBox(width: 8),
              Text('Share'),
            ],
          ),
        ),
        const Spacer(),
        Button(
          onPressed: onDelete,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.red),
          ),
          child: const Row(
            children: [
              Icon(FluentIcons.delete, size: 16),
              SizedBox(width: 8),
              Text('Delete'),
            ],
          ),
        ),
      ],
    );
  }

  void _showShareDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Share Company'),
        content: const Text('Share company information with team members.'),
        actions: [
          Button(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          FilledButton(
            child: const Text('Share'),
            onPressed: () {
              Navigator.pop(context);
              _showSuccessMessage(context, 'Company shared successfully');
            },
          ),
        ],
      ),
    );
  }

  void _showSuccessMessage(BuildContext context, String message) {
    displayInfoBar(
      context,
      builder: (context, close) {
        return InfoBar(
          title: const Text('Success'),
          content: Text(message),
          severity: InfoBarSeverity.success,
          action: IconButton(
            icon: const Icon(FluentIcons.clear),
            onPressed: close,
          ),
        );
      },
    );
  }

  Color _getIndustryColor(String industry) {
    final colors = {
      'Technology': Colors.blue,
      'Finance': Colors.green,
      'Healthcare': Colors.red,
      'Education': Colors.purple,
      'Retail': Colors.orange,
      'Manufacturing': Colors.teal,
    };
    return colors[industry] ?? Colors.grey;
  }
}
