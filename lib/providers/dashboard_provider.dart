import 'package:flutter/foundation.dart';
import '../models/user.dart';

class DashboardProvider with ChangeNotifier {
  List<User> _users = [];
  bool _isLoading = false;
  Map<String, dynamic> _stats = {};
  String? _error;

  List<User> get users => _users;
  bool get isLoading => _isLoading;
  Map<String, dynamic> get stats => _stats;
  String? get error => _error;

  Future<void> loadDashboardData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));

      _stats = {
        'totalUsers': 1234,
        'totalCompanies': 567,
        'activeReports': 89,
        'pendingTasks': 23,
      };

      _users = List.generate(
        10,
        (index) => User(
          id: '${index + 1}',
          name: 'User ${index + 1}',
          email: 'user${index + 1}@example.com',
          role: index % 3 == 0 ? 'Admin' : 'User',
          createdAt: DateTime.now().subtract(Duration(days: index * 10)),
        ),
      );

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addUser(User user) async {
    _users.insert(0, user);
    notifyListeners();
  }

  Future<void> deleteUser(String userId) async {
    _users.removeWhere((user) => user.id == userId);
    notifyListeners();
  }
}
