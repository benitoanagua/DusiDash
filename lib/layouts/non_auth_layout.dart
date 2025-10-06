import 'package:fluent_ui/fluent_ui.dart';

class NonAuthLayout extends StatelessWidget {
  final Widget child;

  const NonAuthLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.dark, Colors.blue, Colors.blue.light],
          ),
        ),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            margin: const EdgeInsets.all(20),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      FluentIcons.dashboard_add,
                      size: 64,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Dusi Dash',
                      style: FluentTheme.of(context).typography.title,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Business Management Dashboard',
                      style: FluentTheme.of(context).typography.body,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
