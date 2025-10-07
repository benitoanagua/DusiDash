import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/companies/companies_tree_view.dart';
import '../widgets/companies/company_details_panel.dart';
import '../widgets/companies/companies_breadcrumb.dart';
import '../widgets/companies/companies_command_bar.dart';
import '../widgets/companies/companies_list_view.dart';
import '../widgets/companies/view_selector.dart';
import '../widgets/search_box.dart';
import '../models/company.dart';

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({super.key});

  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  String _searchQuery = '';
  String _selectedView = 'tree';
  Company? _selectedCompany;
  List<String> _breadcrumbPath = ['Companies'];
  final List<String> _selectedCompanies = [];

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: PageHeader(
        title: const Text('Companies Management'),
        commandBar: CompaniesCommandBar(
          selectedCount: _selectedCompanies.length,
          onAddCompany: _showAddCompanyDialog,
          onRefresh: _refreshData,
          onExport: _showExportOptions,
        ),
      ),
      content: Consumer<DashboardProvider>(
        builder: (context, dashboardProvider, child) {
          if (dashboardProvider.isLoading) {
            return const Center(child: ProgressRing());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CompaniesBreadcrumb(
                path: _breadcrumbPath,
                onItemPressed: _handleBreadcrumbNavigation,
              ),
              const SizedBox(height: 16),
              _buildViewSelector(),
              const SizedBox(height: 16),
              if (_selectedView == 'list') _buildSearchBar(),
              const SizedBox(height: 16),
              Expanded(
                child: _selectedView == 'tree'
                    ? _buildTreeView(dashboardProvider)
                    : CompaniesListView(
                        companies: dashboardProvider.companies,
                        searchQuery: _searchQuery,
                        selectedCompanies: _selectedCompanies,
                        onCompanySelected: _handleCompanySelected,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildViewSelector() {
    return ViewSelector(
      currentView: _selectedView,
      selectedCompany: _selectedCompany,
      selectedCount: _selectedCompanies.length,
      onViewChanged: (view) => setState(() => _selectedView = view),
      onClearSelection: () => setState(() => _selectedCompany = null),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: SearchBox(
            placeholder: 'Search companies by name or industry...',
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
        ),
        if (_selectedCompanies.isNotEmpty) ...[
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${_selectedCompanies.length} selected',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildTreeView(DashboardProvider provider) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: CompaniesTreeView(
            companies: provider.companies,
            selectedCompany: _selectedCompany,
            onCompanySelected: _handleTreeCompanySelected,
            onIndustrySelected: _handleIndustrySelected,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: _selectedCompany != null
              ? CompanyDetailsPanel(
                  company: _selectedCompany!,
                  onEdit: () => _showEditCompanyDialog(_selectedCompany!),
                  onDelete: () => _showDeleteDialog(_selectedCompany!),
                )
              : _buildEmptyState(),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return const Card(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(FluentIcons.business_card, size: 64),
            SizedBox(height: 16),
            Text('Select a company to view details'),
          ],
        ),
      ),
    );
  }

  void _handleBreadcrumbNavigation(int index) {
    setState(() {
      _breadcrumbPath = _breadcrumbPath.sublist(0, index + 1);
      if (index == 0) _selectedCompany = null;
    });
  }

  void _handleTreeCompanySelected(Company company, String industry) {
    setState(() {
      _selectedCompany = company;
      _breadcrumbPath = ['Companies', industry, company.name];
    });
  }

  void _handleIndustrySelected(String industry) {
    setState(() {
      _selectedCompany = null;
      _breadcrumbPath = ['Companies', industry];
    });
  }

  void _handleCompanySelected(Company company) {
    setState(() {
      _selectedCompany = company;
      _selectedView = 'tree';
    });
  }

  void _refreshData() {
    context.read<DashboardProvider>().refreshData();
    _showSuccessMessage('Companies refreshed');
  }

  void _showAddCompanyDialog() {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Add Company'),
        content: const Text('Add company functionality coming soon.'),
        actions: [
          Button(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showEditCompanyDialog(Company company) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Edit Company'),
        content: Text('Edit ${company.name} - coming soon.'),
        actions: [
          Button(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(Company company) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Delete Company'),
        content: Text('Delete ${company.name}?'),
        actions: [
          Button(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          Button(
            child: const Text('Delete'),
            onPressed: () {
              Navigator.pop(context);
              _showSuccessMessage('Company deleted');
            },
          ),
        ],
      ),
    );
  }

  void _showExportOptions() {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Export'),
        content: const Text('Export functionality coming soon.'),
        actions: [
          Button(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showSuccessMessage(String message) {
    displayInfoBar(
      context,
      builder: (context, close) => InfoBar(
        title: const Text('Success'),
        content: Text(message),
        severity: InfoBarSeverity.success,
        action: IconButton(
          icon: const Icon(FluentIcons.clear),
          onPressed: close,
        ),
      ),
    );
  }
}
