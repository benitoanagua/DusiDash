import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/dashboard_provider.dart';
import '../models/user.dart';
import '../core/data/faker_service.dart';

class UserDetailScreen extends StatefulWidget {
  final String userId;

  const UserDetailScreen({super.key, required this.userId});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final _fakerService = FakerService();

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: PageHeader(
        title: const Text('User Details'),
        leading: IconButton(
          icon: const Icon(FluentIcons.back),
          onPressed: () => context.go('/users'),
        ),
      ),
      content: Consumer<DashboardProvider>(
        builder: (context, dashboardProvider, child) {
          final User? user = dashboardProvider.getUserById(widget.userId);

          if (user == null) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FluentIcons.error, size: 48),
                  SizedBox(height: 16),
                  Text('User not found'),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserProfileHeader(user),
                const SizedBox(height: 24),
                _buildUserDetails(user),
                const SizedBox(height: 24),
                _buildUserActivity(user),
                const SizedBox(height: 24),
                _buildActionButtons(user),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserProfileHeader(User user) {
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
                      _UserBadge(
                        text: user.role,
                        color: _getRoleColor(user.role),
                      ),
                      const SizedBox(width: 8),
                      _UserBadge(
                        text: user.status,
                        color: user.isActive ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 8),
                      _UserBadge(text: user.department, color: Colors.blue),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(FluentIcons.edit, size: 20),
              onPressed: () => _editUser(user),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserDetails(User user) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Card(
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
                  _DetailItem(
                    icon: FluentIcons.contact,
                    label: 'Full Name',
                    value: user.name,
                  ),
                  _DetailItem(
                    icon: FluentIcons.mail,
                    label: 'Email Address',
                    value: user.email,
                  ),
                  if (user.phone != null)
                    _DetailItem(
                      icon: FluentIcons.phone,
                      label: 'Phone',
                      value: user.phone!,
                    ),
                  _DetailItem(
                    icon: FluentIcons.business_card,
                    label: 'Company',
                    value: user.company,
                  ),
                  _DetailItem(
                    icon: FluentIcons.group,
                    label: 'Department',
                    value: user.department,
                  ),
                  _DetailItem(
                    icon: FluentIcons.calendar,
                    label: 'Join Date',
                    value: _fakerService.formatDate(user.joinDate),
                  ),
                  _DetailItem(
                    icon: FluentIcons.clock,
                    label: 'Last Login',
                    value: _fakerService.timeAgo(user.lastLogin),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Card(
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
          ),
        ),
      ],
    );
  }

  Widget _buildUserActivity(User user) {
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
            _ActivityItem(
              icon: FluentIcons.user_gauge,
              title: 'Last Login',
              subtitle: _fakerService.timeAgo(user.lastLogin),
              time: user.lastLogin,
            ),
            _ActivityItem(
              icon: FluentIcons.settings,
              title: 'Profile Updated',
              subtitle: 'Personal information modified',
              time: user.joinDate.add(const Duration(days: 30)),
            ),
            _ActivityItem(
              icon: FluentIcons.security_group,
              title: 'Permissions Updated',
              subtitle: 'New access level granted',
              time: user.joinDate.add(const Duration(days: 15)),
            ),
            _ActivityItem(
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

  Widget _buildActionButtons(User user) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            FilledButton(
              onPressed: () => _editUser(user),
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
              onPressed: () => _sendMessage(user),
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
              onPressed: () => _resetPassword(user),
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
              onPressed: () => _showDeactivateDialog(user),
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
              onPressed: () => _showDeleteDialog(user),
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

  void _editUser(User user) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Edit User'),
        content: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextBox(
                placeholder: 'Full Name',
                controller: TextEditingController(text: user.name),
              ),
              const SizedBox(height: 12),
              TextBox(
                placeholder: 'Email',
                controller: TextEditingController(text: user.email),
              ),
              const SizedBox(height: 12),
              TextBox(
                placeholder: 'Phone',
                controller: TextEditingController(text: user.phone ?? ''),
              ),
              const SizedBox(height: 12),
              ComboBox<String>(
                value: user.role,
                items: const [
                  ComboBoxItem(value: 'Admin', child: Text('Administrator')),
                  ComboBoxItem(value: 'Manager', child: Text('Manager')),
                  ComboBoxItem(value: 'User', child: Text('User')),
                  ComboBoxItem(value: 'Viewer', child: Text('Viewer')),
                ],
                onChanged: (value) {},
              ),
            ],
          ),
        ),
        actions: [
          Button(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          FilledButton(
            child: const Text('Save Changes'),
            onPressed: () {
              Navigator.pop(context);
              _showSuccessMessage('User updated successfully');
            },
          ),
        ],
      ),
    );
  }

  void _sendMessage(User user) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Send Message'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Send message to ${user.name}',
                style: FluentTheme.of(context).typography.body,
              ),
              const SizedBox(height: 16),
              TextBox(
                placeholder: 'Subject',
                controller: TextEditingController(),
              ),
              const SizedBox(height: 12),
              TextBox(
                placeholder: 'Message',
                maxLines: 4,
                controller: TextEditingController(),
              ),
            ],
          ),
        ),
        actions: [
          Button(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          FilledButton(
            child: const Text('Send Message'),
            onPressed: () {
              Navigator.pop(context);
              _showSuccessMessage('Message sent to ${user.name}');
            },
          ),
        ],
      ),
    );
  }

  void _resetPassword(User user) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Reset Password'),
        content: Text(
          'Are you sure you want to reset the password for ${user.name}? A new temporary password will be sent to their email.',
        ),
        actions: [
          Button(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          FilledButton(
            child: const Text('Reset Password'),
            onPressed: () {
              Navigator.pop(context);
              _showSuccessMessage('Password reset email sent to ${user.name}');
            },
          ),
        ],
      ),
    );
  }

  void _showDeactivateDialog(User user) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: Text(user.isActive ? 'Deactivate User' : 'Activate User'),
        content: Text(
          user.isActive
              ? 'Are you sure you want to deactivate ${user.name}? They will no longer be able to access the system.'
              : 'Are you sure you want to activate ${user.name}? They will regain access to the system.',
        ),
        actions: [
          Button(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          FilledButton(
            child: Text(user.isActive ? 'Deactivate' : 'Activate'),
            onPressed: () {
              Navigator.pop(context);
              _showSuccessMessage(
                'User ${user.name} ${user.isActive ? 'deactivated' : 'activated'} successfully',
              );
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(User user) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Delete User'),
        content: Text(
          'Are you sure you want to delete ${user.name}? This action cannot be undone and all user data will be permanently removed.',
        ),
        actions: [
          Button(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          Button(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.red),
            ),
            onPressed: () {
              Navigator.pop(context);
              context.go('/users');
              _showSuccessMessage('User ${user.name} deleted successfully');
            },
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
    );
  }

  void _showSuccessMessage(String message) {
    displayInfoBar(
      context,
      builder: (context, close) {
        return InfoBar(
          title: const Text('Success'),
          content: Text(message),
          severity: InfoBarSeverity.success,
          action: IconButton(
            icon: const Icon(FluentIcons.clear),
            onPressed: close,
          ),
        );
      },
    );
  }
}

class _UserBadge extends StatelessWidget {
  final String text;
  final Color color;

  const _UserBadge({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 10),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[100]),
          const SizedBox(width: 12),
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final DateTime time;

  const _ActivityItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final fakerService = FakerService();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blue.withValues(alpha: 10),
            child: Icon(icon, size: 16, color: Colors.blue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey[100]),
                ),
              ],
            ),
          ),
          Text(
            fakerService.timeAgo(time),
            style: TextStyle(fontSize: 12, color: Colors.grey[100]),
          ),
        ],
      ),
    );
  }
}
