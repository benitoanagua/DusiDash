import 'package:fluent_ui/fluent_ui.dart';
import '../../core/data/faker_service.dart';
import 'company_chip.dart';
import 'company_detail_row.dart';

class CompaniesTable extends StatelessWidget {
  final List companies;

  const CompaniesTable({super.key, required this.companies});

  @override
  Widget build(BuildContext context) {
    final fakerService = FakerService();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _TableHeader(companiesCount: companies.length),
            const SizedBox(height: 16),
            Expanded(
              child: companies.isEmpty
                  ? const _EmptyState()
                  : ListView.builder(
                      itemCount: companies.length,
                      itemBuilder: (context, index) {
                        final company = companies[index];
                        return _CompanyTableRow(
                          company: company,
                          fakerService: fakerService,
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

class _TableHeader extends StatelessWidget {
  final int companiesCount;

  const _TableHeader({required this.companiesCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Companies List',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        const Spacer(),
        Text('Total: $companiesCount companies'),
      ],
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
          Icon(FluentIcons.business_card, size: 48),
          SizedBox(height: 16),
          Text('No companies found'),
        ],
      ),
    );
  }
}

class _CompanyTableRow extends StatelessWidget {
  final dynamic company;
  final FakerService fakerService;

  const _CompanyTableRow({required this.company, required this.fakerService});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[30])),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getIndustryColor(company.industry),
          child: Text(
            company.name.substring(0, 2).toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(company.name),
        subtitle: _CompanyDetails(company: company, fakerService: fakerService),
        trailing: _ActionButtons(company: company, fakerService: fakerService),
      ),
    );
  }

  Color _getIndustryColor(String industry) {
    final colors = {
      'technology': Colors.blue,
      'finance': Colors.green,
      'healthcare': Colors.red,
      'education': Colors.orange,
      'retail': Colors.purple,
      'manufacturing': Colors.teal,
    };

    final key = industry.toLowerCase();
    return colors[key] ?? Colors.grey;
  }
}

class _CompanyDetails extends StatelessWidget {
  final dynamic company;
  final FakerService fakerService;

  const _CompanyDetails({required this.company, required this.fakerService});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(company.industry),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(FluentIcons.location, size: 12, color: Colors.grey[100]),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                company.location,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: [
            CompanyChip(
              icon: FluentIcons.people,
              text: '${company.employees} employees',
              color: Colors.blue,
            ),
            CompanyChip(
              icon: FluentIcons.money,
              text: fakerService.formatCurrency(company.revenue),
              color: Colors.green,
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final dynamic company;
  final FakerService fakerService;

  const _ActionButtons({required this.company, required this.fakerService});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(FluentIcons.edit, size: 16),
          onPressed: () => _viewCompanyDetails(context, company, fakerService),
        ),
        IconButton(
          icon: const Icon(FluentIcons.delete, size: 16),
          onPressed: () => _showDeleteDialog(context, company),
        ),
      ],
    );
  }

  void _viewCompanyDetails(
    BuildContext context,
    dynamic company,
    FakerService fakerService,
  ) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: Text('Company Details - ${company.name}'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CompanyDetailRow(
                icon: FluentIcons.business_card,
                label: 'Name',
                value: company.name,
              ),
              CompanyDetailRow(
                icon: FluentIcons.tag,
                label: 'Industry',
                value: company.industry,
              ),
              CompanyDetailRow(
                icon: FluentIcons.people,
                label: 'Employees',
                value: '${company.employees}',
              ),
              CompanyDetailRow(
                icon: FluentIcons.money,
                label: 'Revenue',
                value: fakerService.formatCurrency(company.revenue),
              ),
              CompanyDetailRow(
                icon: FluentIcons.location,
                label: 'Location',
                value: company.location,
              ),
              CompanyDetailRow(
                icon: FluentIcons.calendar,
                label: 'Founded',
                value: _formatDate(company.founded),
              ),
              CompanyDetailRow(
                icon: FluentIcons.globe,
                label: 'Website',
                value: company.website,
              ),
              const SizedBox(height: 8),
              Text(
                'Description:',
                style: FluentTheme.of(context).typography.bodyStrong,
              ),
              const SizedBox(height: 4),
              Text(company.description, style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 8),
              Text(
                'Tags:',
                style: FluentTheme.of(context).typography.bodyStrong,
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: company.tags.map<Widget>((tag) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 10),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        actions: [
          Button(
            child: const Text('Close'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showDeleteDialog(BuildContext context, dynamic company) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Delete Company'),
        content: Text(
          'Are you sure you want to delete ${company.name}? This action cannot be undone.',
        ),
        actions: [
          Button(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          Button(
            child: const Text('Delete'),
            onPressed: () {
              Navigator.pop(context);
              _showSuccessMessage(
                context,
                'Company ${company.name} deleted successfully',
              );
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
}
