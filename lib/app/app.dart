import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/theme_provider.dart';
import 'app_router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = AppRouter.createRouter();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return FluentApp.router(
      title: 'Dusi Dash',
      themeMode: themeProvider.themeMode,
      theme: FluentThemeData(
        brightness: Brightness.light,
        accentColor: Colors.blue,
      ),
      darkTheme: FluentThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.blue,
      ),
      routerConfig: _router,
      locale: const Locale('es'),
      supportedLocales: const [Locale('en'), Locale('es')],
      debugShowCheckedModeBanner: false,
    );
  }
}
