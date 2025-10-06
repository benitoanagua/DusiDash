import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(const DusiDashApp());
}

class DusiDashApp extends StatelessWidget {
  const DusiDashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const App(),
    );
  }
}
