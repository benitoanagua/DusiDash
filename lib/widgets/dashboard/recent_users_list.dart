import 'package:fluent_ui/fluent_ui.dart';
import '../../providers/dashboard_provider.dart';

class RecentUsersList extends StatelessWidget {
  final DashboardProvider provider;

  const RecentUsersList({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: provider.users.take(5).length,
      itemBuilder: (context, index) {
        final user = provider.users[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(user.name.substring(0, 2).toUpperCase()),
          ),
          title: Text(user.name),
          subtitle: Text(user.role),
          trailing: Text(user.lastActiveFormatted),
        );
      },
    );
  }
}
