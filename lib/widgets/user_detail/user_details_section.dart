import 'package:fluent_ui/fluent_ui.dart';
import '../../models/user.dart';
import '../../core/data/faker_service.dart';
import 'detail_item.dart';

class UserDetailsSection extends StatelessWidget {
  final User user;
  final FakerService fakerService;

  const UserDetailsSection({
    super.key,
    required this.user,
    required this.fakerService,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildPersonalInfoCard(context)),
        const SizedBox(width: 16),
        Expanded(child: _buildPermissionsCard(context)),
      ],
    );
  }

  Widget _buildPersonalInfoCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Information',
              style: FluentTheme.of(context).typography.subtitle,
            ),
            const SizedBox(height: 16),
            DetailItem(
              icon: FluentIcons.contact,
              label: 'Full Name',
              value: user.name,
            ),
            DetailItem(
              icon: FluentIcons.mail,
              label: 'Email Address',
              value: user.email,
            ),
            if (user.phone != null)
              DetailItem(
                icon: FluentIcons.phone,
                label: 'Phone',
                value: user.phone!,
              ),
            DetailItem(
              icon: FluentIcons.business_card,
              label: 'Company',
              value: user.company,
            ),
            DetailItem(
              icon: FluentIcons.group,
              label: 'Department',
              value: user.department,
            ),
            DetailItem(
              icon: FluentIcons.calendar,
              label: 'Join Date',
              value: fakerService.formatDate(user.joinDate),
            ),
            DetailItem(
              icon: FluentIcons.clock,
              label: 'Last Login',
              value: fakerService.timeAgo(user.lastLogin),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionsCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Permissions & Access',
              style: FluentTheme.of(context).typography.subtitle,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: user.permissions.map((permission) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 10),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Text(
                    permission.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Text(
              'User Status',
              style: FluentTheme.of(context).typography.bodyStrong,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  user.isActive
                      ? FluentIcons.status_circle_checkmark
                      : FluentIcons.status_circle_error_x,
                  color: user.isActive ? Colors.green : Colors.red,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  user.isActive ? 'Active' : 'Inactive',
                  style: TextStyle(
                    color: user.isActive ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Account Type',
              style: FluentTheme.of(context).typography.bodyStrong,
            ),
            const SizedBox(height: 8),
            Text(
              user.role,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
