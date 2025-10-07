import 'package:fluent_ui/fluent_ui.dart';
import '../../models/company.dart';

class CompaniesTreeView extends StatelessWidget {
  final List<Company> companies;
  final Company? selectedCompany;
  final Function(Company company, String industry) onCompanySelected;
  final Function(String industry) onIndustrySelected;

  const CompaniesTreeView({
    super.key,
    required this.companies,
    required this.selectedCompany,
    required this.onCompanySelected,
    required this.onIndustrySelected,
  });

  @override
  Widget build(BuildContext context) {
    final items = _buildTreeItems();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TreeView(items: items, onItemInvoked: _handleItemInvoked),
      ),
    );
  }

  Future<void> _handleItemInvoked(
    TreeViewItem item,
    TreeViewItemInvokeReason reason,
  ) async {
    final value = item.value.toString();
    if (value.startsWith('company_')) {
      final companyId = value.replaceFirst('company_', '');
      final company = companies.firstWhere((c) => c.id == companyId);
      onCompanySelected(company, company.industry);
    }
  }

  List<TreeViewItem> _buildTreeItems() {
    final Map<String, List<Company>> groupedCompanies = {};

    for (final company in companies) {
      groupedCompanies.putIfAbsent(company.industry, () => []).add(company);
    }

    return groupedCompanies.entries.map((entry) {
      return TreeViewItem(
        content: Text(entry.key),
        value: 'industry_${entry.key}',
        children: entry.value.map((company) {
          return TreeViewItem(
            content: Text(company.name),
            value: 'company_${company.id}',
          );
        }).toList(),
      );
    }).toList();
  }
}
