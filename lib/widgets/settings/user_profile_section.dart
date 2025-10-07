import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import 'profile_stat.dart';

class UserProfileSection extends StatelessWidget {
  final Function(BuildContext) onEditProfile;

  const UserProfileSection({super.key, required this.onEditProfile});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Profile',
              style: FluentTheme.of(context).typography.subtitle,
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  child: Text(
                    authProvider.currentUser?.name
                            .substring(0, 2)
                            .toUpperCase() ??
                        'U',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authProvider.currentUser?.name ?? 'User Name',
                        style: FluentTheme.of(context).typography.title,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        authProvider.currentUser?.email ?? 'user@example.com',
                        style: TextStyle(color: Colors.grey[100]),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        authProvider.currentUser?.role ?? 'User Role',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                FilledButton(
                  onPressed: () => onEditProfile(context),
                  child: const Row(
                    children: [
                      Icon(FluentIcons.edit),
                      SizedBox(width: 8),
                      Text('Edit Profile'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ProfileStat(
                  label: 'Member Since',
                  value: _formatJoinDate(authProvider.currentUser?.joinDate),
                  icon: FluentIcons.calendar,
                ),
                ProfileStat(
                  label: 'Last Login',
                  value: _formatLastLogin(authProvider.currentUser?.lastLogin),
                  icon: FluentIcons.clock,
                ),
                ProfileStat(
                  label: 'Status',
                  value: authProvider.currentUser?.isActive == true
                      ? 'Active'
                      : 'Inactive',
                  icon: FluentIcons.status_circle_checkmark,
                  color: authProvider.currentUser?.isActive == true
                      ? Colors.green
                      : Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatJoinDate(DateTime? date) {
    if (date == null) return 'Unknown';
    return '${date.month}/${date.year}';
  }

  String _formatLastLogin(DateTime? date) {
    if (date == null) return 'Never';
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }
}
