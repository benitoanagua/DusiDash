import 'package:fluent_ui/fluent_ui.dart';
import '../../providers/dashboard_provider.dart';
import '../../core/data/faker_service.dart';

class TopCompaniesList extends StatelessWidget {
  final DashboardProvider provider;

  const TopCompaniesList({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    final fakerService = FakerService();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Top Companies',
              style: FluentTheme.of(context).typography.subtitle,
            ),
            const SizedBox(height: 16),
            ..._buildCompaniesList(provider, fakerService),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCompaniesList(
    DashboardProvider provider,
    FakerService fakerService,
  ) {
    return provider.companies.take(3).map((company) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              child: Text(company.name.substring(0, 2).toUpperCase()),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    company.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    company.industry,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.withValues(alpha: 100),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              fakerService.formatCurrency(company.revenue),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
