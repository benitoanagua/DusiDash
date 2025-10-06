import 'package:fluent_ui/fluent_ui.dart';

class UserDetailScreen extends StatelessWidget {
  final String userId;

  const UserDetailScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(title: Text('User Details - $userId')),
      content: const Center(child: Text('User detail implementation needed')),
    );
  }
}
