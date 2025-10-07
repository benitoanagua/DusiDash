import '../../models/user.dart';
import '../../models/company.dart';
import '../../models/report.dart';
import 'faker_service.dart';

class ModelFactory {
  static final _service = FakerService();
  static final _faker = _service.faker;

  static User createUser() {
    return User(
      id: _faker.datatype.uuid(),
      name: _faker.name.fullName(),
      email: _faker.internet.email(),
      phone: _faker.phoneNumber.phoneNumber(),
      role: _service.randomArrayElement(['Admin', 'Manager', 'User', 'Viewer']),
      company: _faker.company.companyName(),
      department: _faker.commerce.department(),
      avatar: _generateAvatar(),
      status: _service.randomArrayElement(['active', 'inactive', 'pending']),
      joinDate: _service.pastDate(maxYears: 3),
      lastLogin: _service.recentDate(maxDays: 30),
      permissions: _generatePermissions(),
      metadata: _generateUserMetadata(),
    );
  }

  static Company createCompany() {
    final fakerService = FakerService();

    return Company(
      id: _faker.datatype.uuid(),
      name: _faker.company.companyName(),
      industry: _faker.commerce.department(),
      size: _service.randomArrayElement([
        '1-10',
        '11-50',
        '51-200',
        '201-500',
        '501-1000',
        '1000+',
      ]),
      founded: _service.pastDate(maxYears: 20),
      revenue: fakerService.generatePrice(min: 100000, max: 10000000),
      employees: _faker.datatype.number(min: 1, max: 5000),
      location: '${_faker.address.city()}, ${_faker.address.country()}',
      website: _faker.internet.domainName(),
      description: _faker.lorem.paragraph(sentenceCount: 2),
      contact: ContactInfo(
        email: _faker.internet.email(),
        phone: _faker.phoneNumber.phoneNumber(),
        address: _faker.address.streetAddress(),
      ),
      tags: _generateCompanyTags(),
    );
  }

  static Report createReport() {
    final types = [
      'financial',
      'performance',
      'audit',
      'analytics',
      'compliance',
    ];
    final type = _service.randomArrayElement(types);

    return Report(
      id: _faker.datatype.uuid(),
      title: '${_faker.commerce.productName()} Report',
      type: type,
      status: _service.randomArrayElement([
        'draft',
        'in_progress',
        'completed',
        'published',
      ]),
      generatedBy: createUser(),
      createdAt: _service.pastDate(maxYears: 1),
      updatedAt: _service.recentDate(maxDays: 7),
      data: _generateReportData(type),
      metrics: _generateReportMetrics(),
    );
  }

  static String _generateAvatar() {
    final avatars = [
      '👨‍💼',
      '👩‍💼',
      '👨‍🔬',
      '👩‍🔬',
      '👨‍💻',
      '👩‍💻',
      '👨‍🚀',
      '👩‍🚀',
    ];
    return _service.randomArrayElement(avatars);
  }

  static List<String> _generatePermissions() {
    final allPermissions = [
      'read',
      'write',
      'delete',
      'admin',
      'export',
      'import',
    ];
    return _service.randomArrayElements(
      allPermissions,
      count: _faker.datatype.number(min: 1, max: 4),
    );
  }

  static Map<String, dynamic> _generateUserMetadata() {
    return {
      'timezone': _faker.address.timezone(),
      'language': _service.randomArrayElement(['en', 'es', 'fr', 'de']),
      'notifications': _faker.datatype.boolean(),
      'theme': _service.randomArrayElement(['light', 'dark', 'auto']),
    };
  }

  static List<String> _generateCompanyTags() {
    final tags = [
      'Tech',
      'Finance',
      'Healthcare',
      'Education',
      'Retail',
      'Manufacturing',
      'Startup',
      'Enterprise',
    ];
    return _service.randomArrayElements(
      tags,
      count: _faker.datatype.number(min: 1, max: 3),
    );
  }

  static Map<String, dynamic> _generateReportData(String type) {
    switch (type) {
      case 'financial':
        return _generateFinancialData();
      case 'performance':
        return _generatePerformanceData();
      case 'audit':
        return _generateAuditData();
      case 'analytics':
        return _generateAnalyticsData();
      case 'compliance':
        return _generateComplianceData();
      default:
        return {};
    }
  }

  static Map<String, dynamic> _generateFinancialData() {
    final fakerService = FakerService();

    return {
      'revenue': fakerService.generatePrice(min: 10000, max: 1000000),
      'expenses': fakerService.generatePrice(min: 5000, max: 500000),
      'profit': fakerService.generatePrice(min: 5000, max: 500000),
      'growthRate': '${_faker.datatype.number(min: 5, max: 25)}%',
      'quarter':
          'Q${_faker.datatype.number(min: 1, max: 4)} ${DateTime.now().year}',
    };
  }

  static Map<String, dynamic> _generatePerformanceData() {
    return {
      'uptime': '${_faker.datatype.number(min: 95, max: 100)}%',
      'responseTime': '${_faker.datatype.number(min: 100, max: 500)}ms',
      'usersActive': _faker.datatype.number(min: 100, max: 10000),
      'conversionRate': '${_faker.datatype.number(min: 1, max: 15)}%',
    };
  }

  static Map<String, dynamic> _generateAuditData() {
    return {
      'auditScore': _faker.datatype.number(min: 50, max: 100),
      'issuesFound': _faker.datatype.number(min: 0, max: 20),
      'complianceLevel': '${_faker.datatype.number(min: 70, max: 100)}%',
      'lastAudit': _service.pastDate(maxYears: 1).toIso8601String(),
    };
  }

  static Map<String, dynamic> _generateAnalyticsData() {
    return {
      'pageViews': _faker.datatype.number(min: 1000, max: 100000),
      'bounceRate': '${_faker.datatype.number(min: 20, max: 70)}%',
      'sessionDuration': '${_faker.datatype.number(min: 1, max: 30)}min',
      'trafficSources': _generateTrafficSources(),
    };
  }

  static Map<String, dynamic> _generateComplianceData() {
    return {
      'regulations': _service.randomArrayElements([
        'GDPR',
        'HIPAA',
        'SOX',
        'PCI-DSS',
      ], count: 2),
      'complianceStatus': _service.randomArrayElement([
        'compliant',
        'partial',
        'non-compliant',
      ]),
      'lastReview': _service.pastDate(maxYears: 1).toIso8601String(),
      'reviewer': _faker.name.fullName(),
    };
  }

  static Map<String, dynamic> _generateTrafficSources() {
    final sources = [
      'Direct',
      'Organic Search',
      'Social Media',
      'Email',
      'Referral',
    ];
    final result = <String, int>{};

    for (final source in sources) {
      result[source] = _faker.datatype.number(min: 100, max: 10000);
    }

    return result;
  }

  static Map<String, dynamic> _generateReportMetrics() {
    return {
      'completion': _faker.datatype.number(min: 0, max: 100),
      'accuracy': '${_faker.datatype.number(min: 85, max: 100)}%',
      'dataPoints': _faker.datatype.number(min: 100, max: 10000),
      'processingTime': '${_faker.datatype.number(min: 1, max: 60)}min',
    };
  }
}
