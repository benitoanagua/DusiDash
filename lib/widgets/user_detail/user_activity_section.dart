import 'package:fluent_ui/fluent_ui.dart';
import '../../models/user.dart';
import '../../core/data/faker_service.dart';
import 'activity_item.dart';

class UserActivitySection extends StatelessWidget {
  final User user;
  final FakerService fakerService;

  const UserActivitySection({
    super.key,
    required this.user,
    required this.fakerService,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Activity',
              style: FluentTheme.of(context).typography.subtitle,
            ),
            const SizedBox(height: 16),
            ActivityItem(
              icon: FluentIcons.user_gauge,
              title: 'Last Login',
              subtitle: fakerService.timeAgo(user.lastLogin),
              time: user.lastLogin,
            ),
            ActivityItem(
              icon: FluentIcons.settings,
              title: 'Profile Updated',
              subtitle: 'Personal information modified',
              time: user.joinDate.add(const Duration(days: 30)),
            ),
            ActivityItem(
              icon: FluentIcons.security_group,
              title: 'Permissions Updated',
              subtitle: 'New access level granted',
              time: user.joinDate.add(const Duration(days: 15)),
            ),
            ActivityItem(
              icon: FluentIcons.report_document,
              title: 'Report Generated',
              subtitle: 'Monthly performance report',
              time: user.joinDate.add(const Duration(days: 7)),
            ),
          ],
        ),
      ),
    );
  }
}
