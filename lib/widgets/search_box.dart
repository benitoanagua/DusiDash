import 'package:fluent_ui/fluent_ui.dart';

class SearchBox extends StatelessWidget {
  final String placeholder;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSearch;

  const SearchBox({
    super.key,
    required this.placeholder,
    this.onChanged,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return TextBox(
      placeholder: placeholder,
      prefix: const Icon(FluentIcons.search, size: 16),
      onChanged: onChanged,
      suffix: onSearch != null
          ? IconButton(
              icon: const Icon(FluentIcons.search, size: 16),
              onPressed: onSearch,
            )
          : null,
    );
  }
}
