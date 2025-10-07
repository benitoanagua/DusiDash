import 'package:fluent_ui/fluent_ui.dart';

class SettingsHelpers {
  static Widget buildSectionHeader(BuildContext context, String title) {
    return Text(title, style: FluentTheme.of(context).typography.subtitle);
  }

  static Widget buildToggleOption(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: FluentTheme.of(context).typography.bodyStrong),
              const SizedBox(height: 4),
              Text(subtitle, style: FluentTheme.of(context).typography.caption),
            ],
          ),
        ),
        ToggleSwitch(checked: value, onChanged: onChanged),
      ],
    );
  }
}
