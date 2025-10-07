import 'package:fluent_ui/fluent_ui.dart';

class ColorOption extends StatelessWidget {
  final Color color;
  final bool isSelected;

  const ColorOption({super.key, required this.color, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 10),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: isSelected
          ? const Icon(FluentIcons.check_mark, size: 16, color: Colors.white)
          : null,
    );
  }
}
