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
  Map<String, dynamic> _stats = {};
  Map<String, dynamic> _metrics = {};

  List<User> get users => _users;
  List<Company> get companies => _companies;
  List<Report> get reports => _reports;
  bool get isLoading => _isLoading;
  Map<String, dynamic> get stats => _stats;
  Map<String, dynamic> get metrics => _metrics;

  DashboardProvider() {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.wait([
        _loadUsers(),
        _loadCompanies(),
        _loadReports(),
        _generateStats(),
        _generateMetrics(),
      ]);
    } catch (e) {
      if (kDebugMode) {
        print('Error loading dashboard data: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadUsers() async {
    await Future.delayed(const Duration(milliseconds: 800));
    _users = List.generate(12, (index) => ModelFactory.createUser());
  }

  Future<void> _loadCompanies() async {
    await Future.delayed(const Duration(milliseconds: 600));
    _companies = List.generate(8, (index) => ModelFactory.createCompany());
  }

  Future<void> _loadReports() async {
    await Future.delayed(const Duration(milliseconds: 400));
    _reports = List.generate(6, (index) => ModelFactory.createReport());
  }

  Future<void> _generateStats() async {
    await Future.delayed(const Duration(milliseconds: 500));

    _stats = {
      'totalUsers': _users.length,
      'totalCompanies': _companies.length,
      'activeReports': _reports.where((r) => r.status == 'completed').length,
      'pendingTasks': _reports.where((r) => r.status == 'in_progress').length,
      'revenue': _companies.fold<double>(
        0,
        (sum, company) => sum + company.revenue,
      ),
      'activeUsers': _users.where((u) => u.isActive).length,
    };
  }

  Future<void> _generateMetrics() async {
    await Future.delayed(const Duration(milliseconds: 300));

    _metrics = {
      'userGrowth': '${_randomGrowth()}%',
      'revenueGrowth': '${_randomGrowth()}%',
      'engagementRate': '${_randomPercentage()}%',
      'conversionRate': '${_randomPercentage()}%',
      'satisfactionScore': '${_randomScore()}/100',
    };
  }

  int _randomGrowth() => DateTime.now().millisecondsSinceEpoch % 20 + 5;
  int _randomPercentage() => DateTime.now().millisecondsSinceEpoch % 50 + 50;
  int _randomScore() => DateTime.now().millisecondsSinceEpoch % 30 + 70;

  void refreshData() {
    loadDashboardData();
  }
}
