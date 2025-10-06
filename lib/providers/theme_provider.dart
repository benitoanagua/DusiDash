import 'package:fluent_ui/fluent_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  static const String _themeKey = 'theme_mode';

  ThemeMode get themeMode => _themeMode;
  bool get isDark => _themeMode == ThemeMode.dark;
  bool get isLight => _themeMode == ThemeMode.light;
  bool get isSystem => _themeMode == ThemeMode.system;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedMode = prefs.getString(_themeKey);

      if (savedMode != null) {
        _themeMode = ThemeMode.values.firstWhere(
          (mode) => mode.toString() == savedMode,
          orElse: () => ThemeMode.system,
        );
      }

      notifyListeners();
    } catch (e) {
      _themeMode = ThemeMode.system;
    }
  }

  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeKey, _themeMode.toString());
      notifyListeners();
    } catch (e) {
      // Ignorar errores de persistencia
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;

    _themeMode = mode;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeKey, mode.toString());
      notifyListeners();
    } catch (e) {
      // Ignorar errores de persistencia
    }
  }
}
