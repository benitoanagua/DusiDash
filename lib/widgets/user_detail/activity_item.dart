import 'package:fluent_ui/fluent_ui.dart';
import '../../core/data/faker_service.dart';

class ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final DateTime time;

  const ActivityItem({
    super.key,
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
