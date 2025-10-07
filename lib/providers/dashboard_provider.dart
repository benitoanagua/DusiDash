import 'package:flutter/foundation.dart';
import '../core/data/model_factories.dart';
import '../models/user.dart';
import '../models/company.dart';
import '../models/report.dart';

class DashboardProvider with ChangeNotifier {
  List<User> _users = [];
  List<Company> _companies = [];
  List<Report> _reports = [];
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';
  Map<String, dynamic> _stats = {};
  Map<String, dynamic> _metrics = {};

  List<User> get users => _users;
  List<Company> get companies => _companies;
  List<Report> get reports => _reports;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;
  Map<String, dynamic> get stats => _stats;
  Map<String, dynamic> get metrics => _metrics;

  DashboardProvider() {
    Future.microtask(() => loadDashboardData());
  }

  Future<void> loadDashboardData() async {
    if (_isLoading) return;

    _isLoading = true;
    _hasError = false;
    _errorMessage = '';
    notifyListeners();

    try {
      await _loadUsers();
      await _loadCompanies();
      await _loadReports();

      await _generateStats();
      await _generateMetrics();

      if (kDebugMode) {
        print('Dashboard data loaded successfully:');
        print(' - Users: ${_users.length}');
        print(' - Companies: ${_companies.length}');
        print(' - Reports: ${_reports.length}');
      }
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
      if (kDebugMode) {
        print('Error loading dashboard data: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadUsers() async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      _users = List.generate(15, (index) => ModelFactory.createUser());

      if (_users.isEmpty) {
        throw Exception('No users were generated');
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  Future<void> _loadCompanies() async {
    try {
      await Future.delayed(const Duration(milliseconds: 600));
      _companies = List.generate(10, (index) => ModelFactory.createCompany());

      if (_companies.isEmpty) {
        throw Exception('No companies were generated');
      }
    } catch (e) {
      throw Exception('Failed to load companies: $e');
    }
  }

  Future<void> _loadReports() async {
    try {
      await Future.delayed(const Duration(milliseconds: 400));
      _reports = List.generate(8, (index) => ModelFactory.createReport());

      if (_reports.isEmpty) {
        throw Exception('No reports were generated');
      }
    } catch (e) {
      throw Exception('Failed to load reports: $e');
    }
  }

  Future<void> _generateStats() async {
    try {
      await Future.delayed(const Duration(milliseconds: 200));

      final totalRevenue = _companies.fold<double>(
        0,
        (sum, company) => sum + company.revenue,
      );

      _stats = {
        'totalUsers': _users.length,
        'totalCompanies': _companies.length,
        'activeReports': _reports.where((r) => r.status == 'completed').length,
        'pendingTasks': _reports.where((r) => r.status == 'in_progress').length,
        'revenue': totalRevenue,
        'activeUsers': _users.where((u) => u.isActive).length,
      };
    } catch (e) {
      throw Exception('Failed to generate stats: $e');
    }
  }

  Future<void> _generateMetrics() async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      _metrics = {
        'userGrowth': '${_randomGrowth()}%',
        'revenueGrowth': '${_randomGrowth()}%',
        'engagementRate': '${_randomPercentage()}%',
        'conversionRate': '${_randomPercentage()}%',
        'satisfactionScore': '${_randomScore()}/100',
      };
    } catch (e) {
      throw Exception('Failed to generate metrics: $e');
    }
  }

  int _randomGrowth() => DateTime.now().millisecondsSinceEpoch % 20 + 5;
  int _randomPercentage() => DateTime.now().millisecondsSinceEpoch % 30 + 70;
  int _randomScore() => DateTime.now().millisecondsSinceEpoch % 20 + 80;

  Future<void> refreshData() async {
    if (kDebugMode) {
      print('Refreshing dashboard data...');
    }
    await loadDashboardData();
  }

  User? getUserById(String id) {
    try {
      return _users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }

  Company? getCompanyById(String id) {
    try {
      return _companies.firstWhere((company) => company.id == id);
    } catch (e) {
      return null;
    }
  }

  Report? getReportById(String id) {
    try {
      return _reports.firstWhere((report) => report.id == id);
    } catch (e) {
      return null;
    }
  }

  void clearError() {
    _hasError = false;
    _errorMessage = '';
    notifyListeners();
  }

  bool get hasData =>
      _users.isNotEmpty && _companies.isNotEmpty && _reports.isNotEmpty;
}
