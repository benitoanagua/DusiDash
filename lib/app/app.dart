import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../screens/dashboard_screen.dart';
import '../providers/theme_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return FluentApp(
      title: 'Dusi Dash',
      theme: FluentThemeData(
        brightness: themeProvider.isDark ? Brightness.dark : Brightness.light,
        accentColor: Colors.blue,
      ),
      darkTheme: FluentThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.blue,
      ),
      home: const DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
