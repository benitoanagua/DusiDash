import 'package:fluent_ui/fluent_ui.dart';
import '../../models/user.dart';
import 'user_badge.dart';

class UserProfileHeader extends StatelessWidget {
  final User user;
  final VoidCallback onEdit;

  const UserProfileHeader({
    super.key,
    required this.user,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: _getRoleColor(user.role),
              child: Text(
                user.name.substring(0, 2).toUpperCase(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: FluentTheme.of(context).typography.title,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.email,
                    style: TextStyle(fontSize: 16, color: Colors.grey[100]),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      UserBadge(
                        text: user.role,
                        color: _getRoleColor(user.role),
                      ),
                      const SizedBox(width: 8),
                      UserBadge(
                        text: user.status,
                        color: user.isActive ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 8),
                      UserBadge(text: user.department, color: Colors.blue),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(FluentIcons.edit, size: 20),
              onPressed: onEdit,
            ),
          ],
        ),
      ),
    );
  }

  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return Colors.red;
      case 'manager':
        return Colors.orange;
      case 'user':
        return Colors.blue;
      case 'viewer':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
