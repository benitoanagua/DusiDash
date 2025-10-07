import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/search_box.dart';
import '../core/data/faker_service.dart';

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({super.key});

  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: const PageHeader(title: Text('Companies Management')),
      content: Consumer<DashboardProvider>(
        builder: (context, dashboardProvider, child) {
          final filteredCompanies = _searchQuery.isEmpty
              ? dashboardProvider.companies
              : dashboardProvider.companies.where((company) {
                  return company.name.toLowerCase().contains(
                        _searchQuery.toLowerCase(),
                      ) ||
                      company.industry.toLowerCase().contains(
                        _searchQuery.toLowerCase(),
                      ) ||
                      company.location.toLowerCase().contains(
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
                    : _CompaniesTable(companies: filteredCompanies),
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
            placeholder: 'Search companies by name, industry or location...',
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ),
        const SizedBox(width: 16),
        FilledButton(
          onPressed: () => _showAddCompanyDialog(context),
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

  void _showAddCompanyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Add New Company'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextBox(placeholder: 'Company Name'),
            const SizedBox(height: 12),
            TextBox(placeholder: 'Industry'),
            const SizedBox(height: 12),
            TextBox(placeholder: 'Location'),
          ],
        ),
        actions: [
          Button(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          FilledButton(
            child: const Text('Add Company'),
            onPressed: () {
              Navigator.pop(context);
              _showSuccessMessage(context, 'Company added successfully');
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

class _CompaniesTable extends StatelessWidget {
  final List companies;

  const _CompaniesTable({required this.companies});

  @override
  Widget build(BuildContext context) {
    final fakerService = FakerService();

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
                Text('Total: ${companies.length} companies'),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: companies.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FluentIcons.business_card, size: 48),
                          SizedBox(height: 16),
                          Text('No companies found'),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: companies.length,
                      itemBuilder: (context, index) {
                        final company = companies[index];
                        return Container(
                          decoration: BoxDecoration(
                            border: index < companies.length - 1
                                ? Border(
                                    bottom: BorderSide(color: Colors.grey[30]),
                                  )
                                : null,
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: _getIndustryColor(
                                company.industry,
                              ),
                              child: Text(
                                company.name.substring(0, 2).toUpperCase(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(company.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(company.industry),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      FluentIcons.location,
                                      size: 12,
                                      color: Colors.grey[100],
                                    ),
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
                                    _CompanyChip(
                                      icon: FluentIcons.people,
                                      text: '${company.employees} employees',
                                      color: Colors.blue,
                                    ),
                                    _CompanyChip(
                                      icon: FluentIcons.money,
                                      text: fakerService.formatCurrency(
                                        company.revenue,
                                      ),
                                      color: Colors.green,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(FluentIcons.edit, size: 16),
                                  onPressed: () => _viewCompanyDetails(
                                    context,
                                    company,
                                    fakerService,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    FluentIcons.delete,
                                    size: 16,
                                  ),
                                  onPressed: () =>
                                      _showDeleteDialog(context, company),
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

  void _viewCompanyDetails(
    BuildContext context,
    company,
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
              _CompanyDetailRow(
                icon: FluentIcons.business_card,
                label: 'Name',
                value: company.name,
              ),
              _CompanyDetailRow(
                icon: FluentIcons.tag,
                label: 'Industry',
                value: company.industry,
              ),
              _CompanyDetailRow(
                icon: FluentIcons.people,
                label: 'Employees',
                value: '${company.employees}',
              ),
              _CompanyDetailRow(
                icon: FluentIcons.money,
                label: 'Revenue',
                value: fakerService.formatCurrency(company.revenue),
              ),
              _CompanyDetailRow(
                icon: FluentIcons.location,
                label: 'Location',
                value: company.location,
              ),
              _CompanyDetailRow(
                icon: FluentIcons.calendar,
                label: 'Founded',
                value: _formatDate(company.founded),
              ),
              _CompanyDetailRow(
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

  void _showDeleteDialog(BuildContext context, company) {
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

class _CompanyChip extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _CompanyChip({
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 10),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _CompanyDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _CompanyDetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[100]),
          const SizedBox(width: 8),
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
