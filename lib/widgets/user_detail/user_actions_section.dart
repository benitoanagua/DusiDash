import 'package:fluent_ui/fluent_ui.dart';
import '../../models/user.dart';

class UserActionsSection extends StatelessWidget {
  final User user;
  final VoidCallback onEdit;
  final VoidCallback onSendMessage;
  final VoidCallback onResetPassword;
  final VoidCallback onDeactivate;
  final VoidCallback onDelete;

  const UserActionsSection({
    super.key,
    required this.user,
    required this.onEdit,
    required this.onSendMessage,
    required this.onResetPassword,
    required this.onDeactivate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            FilledButton(
              onPressed: onEdit,
              child: const Row(
                children: [
                  Icon(FluentIcons.edit),
                  SizedBox(width: 8),
                  Text('Edit User'),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Button(
              onPressed: onSendMessage,
              child: const Row(
                children: [
                  Icon(FluentIcons.mail),
                  SizedBox(width: 8),
                  Text('Send Message'),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Button(
              onPressed: onResetPassword,
              child: const Row(
                children: [
                  Icon(FluentIcons.password_field),
                  SizedBox(width: 8),
                  Text('Reset Password'),
                ],
              ),
            ),
            const Spacer(),
            Button(
              onPressed: onDeactivate,
              child: Row(
                children: [
                  Icon(
                    user.isActive
                        ? FluentIcons.block_contact
                        : FluentIcons.activate_orders,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(user.isActive ? 'Deactivate' : 'Activate'),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Button(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.red),
              ),
              onPressed: onDelete,
              child: const Row(
                children: [
                  Icon(FluentIcons.delete),
                  SizedBox(width: 8),
                  Text('Delete User'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
