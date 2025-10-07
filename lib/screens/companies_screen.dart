import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/search_box.dart';
import '../widgets/companies/companies_table.dart';

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
                    : CompaniesTable(companies: filteredCompanies),
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
        CommandBar(
          overflowBehavior: CommandBarOverflowBehavior.noWrap,
          primaryItems: [
            CommandBarBuilderItem(
              builder: (context, mode, w) =>
                  Tooltip(message: 'Add a new company', child: w),
              wrappedItem: CommandBarButton(
                icon: const Icon(FluentIcons.add),
                label: const Text('Add Company'),
                onPressed: () => _showAddCompanyDialog(context),
              ),
            ),
          ],
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
