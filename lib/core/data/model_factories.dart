import 'package:faker_dart/faker_dart.dart';
import '../../models/user.dart';
import '../../models/company.dart';
import '../../models/report.dart';
import 'faker_service.dart';

class ModelFactory {
  static User createUser([Faker? faker]) {
    final f = faker ?? FakerService().faker;
    final service = FakerService();

    return User(
      id: f.datatype.uuid(),
      name: f.name.fullName(),
      email: f.internet.email(),
      phone: f.phoneNumber.phoneNumber(),
      role: service.randomArrayElement(['Admin', 'Manager', 'User', 'Viewer']),
      company: f.company.companyName(),
      department: f.commerce.department(),
      avatar: _generateAvatar(service),
      status: service.randomArrayElement(['active', 'inactive', 'pending']),
      joinDate: service.pastDate(maxYears: 3),
      lastLogin: service.recentDate(maxDays: 30),
      permissions: _generatePermissions(service),
      metadata: _generateUserMetadata(service),
    );
  }

  static Company createCompany([Faker? faker]) {
    final f = faker ?? FakerService().faker;
    final service = FakerService();

    return Company(
      id: f.datatype.uuid(),
      name: f.company.companyName(),
      industry: f.commerce.department(),
      size: service.randomArrayElement([
        '1-10',
        '11-50',
        '51-200',
        '201-500',
        '501-1000',
        '1000+',
      ]),
      founded: service.pastDate(maxYears: 20),
      revenue: double.parse(f.commerce.price(min: 100000, max: 10000000)),
      employees: f.datatype.number(min: 1, max: 5000),
      location: '${f.address.city()}, ${f.address.country()}',
      website: f.internet.domainName(),
      description: f.lorem.paragraph(sentenceCount: 2),
      contact: ContactInfo(
        email: f.internet.email(),
        phone: f.phoneNumber.phoneNumber(),
        address: f.address.streetAddress(),
      ),
      tags: _generateCompanyTags(service),
    );
  }

  static Report createReport([Faker? faker]) {
    final f = faker ?? FakerService().faker;
    final service = FakerService();
    final types = [
      'financial',
      'performance',
      'audit',
      'analytics',
      'compliance',
    ];

    return Report(
      id: f.datatype.uuid(),
      title: '${f.commerce.productName()} Report',
      type: service.randomArrayElement(types),
      status: service.randomArrayElement([
        'draft',
        'in_progress',
        'completed',
        'published',
      ]),
      generatedBy: createUser(f),
      createdAt: service.pastDate(maxYears: 1),
      updatedAt: service.recentDate(maxDays: 7),
      data: _generateReportData(
        f,
        service,
        types.indexOf(service.randomArrayElement(types)),
      ),
      metrics: _generateReportMetrics(service),
    );
  }

  static String _generateAvatar(FakerService service) {
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
    return service.randomArrayElement(avatars);
  }

  static List<String> _generatePermissions(FakerService service) {
    final allPermissions = [
      'read',
      'write',
      'delete',
      'admin',
      'export',
      'import',
    ];
    return service.randomArrayElements(
      allPermissions,
      count: service.faker.datatype.number(min: 1, max: 4),
    );
  }

  static Map<String, dynamic> _generateUserMetadata(FakerService service) {
    return {
      'timezone': service.faker.address.timezone(),
      'language': service.randomArrayElement(['en', 'es', 'fr', 'de']),
      'notifications': service.faker.datatype.boolean(),
      'theme': service.randomArrayElement(['light', 'dark', 'auto']),
    };
  }

  static List<String> _generateCompanyTags(FakerService service) {
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
    return service.randomArrayElements(
      tags,
      count: service.faker.datatype.number(min: 1, max: 3),
    );
  }

  static Map<String, dynamic> _generateReportData(
    Faker faker,
    FakerService service,
    int typeIndex,
  ) {
    final dataTypes = [
      _generateFinancialData,
      _generatePerformanceData,
      _generateAuditData,
      _generateAnalyticsData,
      _generateComplianceData,
    ];

    return dataTypes[typeIndex](faker, service);
  }

  static Map<String, dynamic> _generateFinancialData(
    Faker faker,
    FakerService service,
  ) {
    return {
      'revenue': double.parse(faker.commerce.price(min: 10000, max: 1000000)),
      'expenses': double.parse(faker.commerce.price(min: 5000, max: 500000)),
      'profit': double.parse(faker.commerce.price(min: 5000, max: 500000)),
      'growthRate': '${faker.datatype.number(min: 5, max: 25)}%',
      'quarter':
          'Q${faker.datatype.number(min: 1, max: 4)} ${DateTime.now().year}',
    };
  }

  static Map<String, dynamic> _generatePerformanceData(
    Faker faker,
    FakerService service,
  ) {
    return {
      'uptime': '${faker.datatype.number(min: 95, max: 100)}%',
      'responseTime': '${faker.datatype.number(min: 100, max: 500)}ms',
      'usersActive': faker.datatype.number(min: 100, max: 10000),
      'conversionRate': '${faker.datatype.number(min: 1, max: 15)}%',
    };
  }

  static Map<String, dynamic> _generateAuditData(
    Faker faker,
    FakerService service,
  ) {
    return {
      'auditScore': faker.datatype.number(min: 50, max: 100),
      'issuesFound': faker.datatype.number(min: 0, max: 20),
      'complianceLevel': '${faker.datatype.number(min: 70, max: 100)}%',
      'lastAudit': service.pastDate(maxYears: 1).toIso8601String(),
    };
  }

  static Map<String, dynamic> _generateAnalyticsData(
    Faker faker,
    FakerService service,
  ) {
    return {
      'pageViews': faker.datatype.number(min: 1000, max: 100000),
      'bounceRate': '${faker.datatype.number(min: 20, max: 70)}%',
      'sessionDuration': '${faker.datatype.number(min: 1, max: 30)}min',
      'trafficSources': _generateTrafficSources(service),
    };
  }

  static Map<String, dynamic> _generateComplianceData(
    Faker faker,
    FakerService service,
  ) {
    return {
      'regulations': service.randomArrayElements([
        'GDPR',
        'HIPAA',
        'SOX',
        'PCI-DSS',
      ], count: 2),
      'complianceStatus': service.randomArrayElement([
        'compliant',
        'partial',
        'non-compliant',
      ]),
      'lastReview': service.pastDate(maxYears: 1).toIso8601String(),
      'reviewer': faker.name.fullName(),
    };
  }

  static Map<String, dynamic> _generateTrafficSources(FakerService service) {
    final sources = [
      'Direct',
      'Organic Search',
      'Social Media',
      'Email',
      'Referral',
    ];
    final result = <String, int>{};

    for (final source in sources) {
      result[source] = service.faker.datatype.number(min: 100, max: 10000);
    }

    return result;
  }

  static Map<String, dynamic> _generateReportMetrics(FakerService service) {
    return {
      'completion': service.faker.datatype.number(min: 0, max: 100),
      'accuracy': '${service.faker.datatype.number(min: 85, max: 100)}%',
      'dataPoints': service.faker.datatype.number(min: 100, max: 10000),
      'processingTime': '${service.faker.datatype.number(min: 1, max: 60)}min',
    };
  }
}
