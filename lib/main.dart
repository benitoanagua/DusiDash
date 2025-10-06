import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';
import 'providers/theme_provider.dart';
import 'providers/dashboard_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeProvider = ThemeProvider();
  // await themeProvider.loadTheme();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeProvider),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
      ],
      child: const App(),
    ),
  );
}
