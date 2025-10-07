import 'package:fluent_ui/fluent_ui.dart';

class AnalyticsItem extends StatelessWidget {
  final String label;
  final String value;
  final String change;
  final bool isPositive;
  final IconData icon;
  final Color color;

  const AnalyticsItem({
    super.key,
    required this.label,
    required this.value,
    required this.change,
    required this.isPositive,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withValues(alpha: 10),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      value,
                      style: FluentTheme.of(context).typography.subtitle,
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: isPositive
                            ? Colors.green.withValues(alpha: 10)
                            : Colors.red.withValues(alpha: 10),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isPositive
                                ? FluentIcons.arrow_up_right
                                : FluentIcons.arrow_down_right8,
                            size: 10,
                            color: isPositive ? Colors.green : Colors.red,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            change,
                            style: TextStyle(
                              fontSize: 10,
                              color: isPositive ? Colors.green : Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
