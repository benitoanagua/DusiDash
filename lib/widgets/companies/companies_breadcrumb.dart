import 'package:fluent_ui/fluent_ui.dart';

class CompaniesBreadcrumb extends StatelessWidget {
  final List<String> path;
  final Function(int index) onItemPressed;

  const CompaniesBreadcrumb({
    super.key,
    required this.path,
    required this.onItemPressed,
  });

  @override
  Widget build(BuildContext context) {
    final items = path.asMap().entries.map((entry) {
      return BreadcrumbItem<int>(label: Text(entry.value), value: entry.key);
    }).toList();

    return BreadcrumbBar<int>(
      items: items,
      onItemPressed: (item) {
        onItemPressed(item.value);
      },
    );
  }
}
