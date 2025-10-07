import 'package:fluent_ui/fluent_ui.dart';
import '../../models/company.dart';

class CompaniesListView extends StatelessWidget {
  final List<Company> companies;
  final String searchQuery;
  final List<String> selectedCompanies;
  final ValueChanged<Company> onCompanySelected;

  const CompaniesListView({
    super.key,
    required this.companies,
    required this.searchQuery,
    required this.selectedCompanies,
    required this.onCompanySelected,
  });

  @override
  Widget build(BuildContext context) {
    final filteredCompanies = _getFilteredCompanies();

    return Card(
      child: filteredCompanies.isEmpty
          ? const _EmptyState()
          : ListView.builder(
              itemCount: filteredCompanies.length,
              itemBuilder: (context, index) {
                final company = filteredCompanies[index];
                return _CompanyListTile(
                  company: company,
                  isSelected: selectedCompanies.contains(company.id),
                  onTap: () => onCompanySelected(company),
                );
              },
            ),
    );
  }

  List<Company> _getFilteredCompanies() {
    if (searchQuery.isEmpty) return companies;

    return companies.where((company) {
      return company.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          company.industry.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }
}

class _CompanyListTile extends StatelessWidget {
  final Company company;
  final bool isSelected;
  final VoidCallback onTap;

  const _CompanyListTile({
    required this.company,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile.selectable(
      leading: CircleAvatar(
        backgroundColor: _getIndustryColor(company.industry),
        child: Text(
          company.name.substring(0, 2).toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(company.name),
      subtitle: Text('${company.industry} • ${company.location}'),
      trailing: Text('${company.employees} employees'),
      selected: isSelected,
      onSelectionChange: (selected) => onTap(),
    );
  }

  Color _getIndustryColor(String industry) {
    final colors = {
      'Technology': Colors.blue,
      'Finance': Colors.green,
      'Healthcare': Colors.red,
      'Education': Colors.purple,
    };
    return colors[industry] ?? Colors.grey;
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
          Icon(FluentIcons.search, size: 48),
          SizedBox(height: 16),
          Text('No companies found'),
        ],
      ),
    );
  }
}
