import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';

class UserTableRow extends StatelessWidget {
  final dynamic user;

  const UserTableRow({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[30])),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(user.name.substring(0, 2).toUpperCase()),
        ),
        title: Text(user.name),
        subtitle: _UserDetails(user: user),
        trailing: _ActionButtons(user: user),
      ),
    );
  }
}

class _UserDetails extends StatelessWidget {
  final dynamic user;

  const _UserDetails({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(user.email),
        const SizedBox(height: 4),
        _RoleBadge(role: user.role),
      ],
    );
  }
}

class _RoleBadge extends StatelessWidget {
  final String role;

  const _RoleBadge({required this.role});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getRoleColor(role).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Text(
        role,
        style: TextStyle(fontSize: 12, color: _getRoleColor(role)),
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
      default:
        return Colors.grey;
    }
  }
}

class _ActionButtons extends StatelessWidget {
  final dynamic user;

  const _ActionButtons({required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(FluentIcons.edit, size: 16),
          onPressed: () => _viewUserDetails(context, user.id),
        ),
        IconButton(
          icon: const Icon(FluentIcons.delete, size: 16),
          onPressed: () => _showDeleteDialog(context, user),
        ),
      ],
    );
  }

  void _viewUserDetails(BuildContext context, String userId) {
    context.go('/users/$userId');
  }

  void _showDeleteDialog(BuildContext context, user) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Delete User'),
        content: Text('Are you sure you want to delete ${user.name}?'),
        actions: [
          Button(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          Button(
            child: const Text('Delete'),
            onPressed: () {
              Navigator.pop(context);
              _showComingSoonDialog(context, 'Delete User');
            },
          ),
        ],
      ),
    );
  }

  void _showComingSoonDialog(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: Text(feature),
        content: Text('$feature feature coming soon.'),
        actions: [
          Button(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
