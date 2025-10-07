import 'package:fluent_ui/fluent_ui.dart';
import '../../models/company.dart';

class ViewSelector extends StatelessWidget {
  final String currentView;
  final Company? selectedCompany;
  final int selectedCount;
  final ValueChanged<String> onViewChanged;
  final VoidCallback onClearSelection;

  const ViewSelector({
    super.key,
    required this.currentView,
    this.selectedCompany,
    required this.selectedCount,
    required this.onViewChanged,
    required this.onClearSelection,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const Icon(FluentIcons.view),
            const SizedBox(width: 12),
            const Text('View:'),
            const SizedBox(width: 12),
            ToggleButton(
              checked: currentView == 'tree',
              onChanged: (v) => onViewChanged('tree'),
              child: const Text('Tree View'),
            ),
            const SizedBox(width: 8),
            ToggleButton(
              checked: currentView == 'list',
              onChanged: (v) => onViewChanged('list'),
              child: const Text('List View'),
            ),
            const Spacer(),
            if (selectedCompany != null) ...[
              Text('Selected: ${selectedCompany!.name}'),
              const SizedBox(width: 12),
              Button(onPressed: onClearSelection, child: const Text('Clear')),
            ] else if (selectedCount > 0) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$selectedCount selected',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
