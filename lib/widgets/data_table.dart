import 'package:fluent_ui/fluent_ui.dart';

class DataTableWidget extends StatelessWidget {
  final List<String> columns;
  final List<List<String>> data;
  final List<Widget>? actions;

  const DataTableWidget({
    super.key,
    required this.columns,
    required this.data,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (actions != null) ...[
              Row(children: actions!),
              const SizedBox(height: 16),
            ],
            Expanded(
              child: ListView(
                children: [
                  // Header
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[20],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: columns
                          .map(
                            (column) => Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  column,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  // Data rows
                  ...data.map(
                    (row) => Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey[30]),
                        ),
                      ),
                      child: Row(
                        children: row
                            .map(
                              (cell) => Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(cell),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
