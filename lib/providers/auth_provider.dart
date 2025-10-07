import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../core/data/model_factories.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;
  bool _isAuthenticated = false;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    if (username.isNotEmpty && password.isNotEmpty) {
      _isAuthenticated = true;
      _currentUser = ModelFactory.createUser();

      // Override email with login username
      _currentUser = User(
        id: _currentUser!.id,
        name: _currentUser!.name,
        email: username,
        phone: _currentUser!.phone,
        role: 'Admin',
        company: _currentUser!.company,
        department: _currentUser!.department,
        avatar: _currentUser!.avatar,
        status: 'active',
        joinDate: _currentUser!.joinDate,
        lastLogin: DateTime.now(),
        permissions: ['read', 'write', 'admin'],
        metadata: _currentUser!.metadata,
      );

      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  void logout() {
    _isAuthenticated = false;
    _currentUser = null;
    notifyListeners();
  }

  Future<void> checkAuthStatus() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
