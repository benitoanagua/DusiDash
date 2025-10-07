import 'package:faker_dart/faker_dart.dart';

class FakerService {
  static final FakerService _instance = FakerService._internal();
  final Faker _faker = Faker.instance;

  factory FakerService() => _instance;

  FakerService._internal();

  Faker get faker => _faker;

  T randomArrayElement<T>(List<T> list) {
    if (list.isEmpty) throw ArgumentError('List cannot be empty');
    final index = _faker.datatype.number(max: list.length - 1);
    return list[index];
  }

  List<T> randomArrayElements<T>(List<T> list, {int count = 1}) {
    if (list.isEmpty) return [];
    final shuffled = List<T>.from(list)..shuffle();
    return shuffled.take(count.clamp(0, list.length)).toList();
  }

  DateTime pastDate({int maxYears = 5}) {
    final years = _faker.datatype.number(max: maxYears);
    final days = _faker.datatype.number(max: 365);
    return DateTime.now().subtract(Duration(days: days + (years * 365)));
  }

  DateTime recentDate({int maxDays = 30}) {
    final days = _faker.datatype.number(max: maxDays);
    final hours = _faker.datatype.number(max: 23);
    return DateTime.now().subtract(Duration(days: days, hours: hours));
  }

  String formatCurrency(double amount) {
    if (amount >= 1000000) {
      return '\$${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '\$${(amount / 1000).toStringAsFixed(1)}K';
    }
    return '\$${amount.toStringAsFixed(0)}';
  }

  String formatPercentage(int value) {
    return '$value%';
  }

  double parsePrice(String price) {
    try {
      final cleaned = price.replaceAll(RegExp(r'[^\d.]'), '');
      return double.tryParse(cleaned) ?? 0.0;
    } catch (e) {
      return 0.0;
    }
  }

  double generatePrice({double min = 1000, double max = 100000}) {
    final priceString = _faker.commerce.price(
      min: min.toDouble(),
      max: max.toDouble(),
    );
    return parsePrice(priceString);
  }

  Map<String, dynamic> generateCompanyData() {
    return {
      'name': _faker.company.companyName(),
      'industry': _faker.commerce.department(),
      'employees': _faker.datatype.number(min: 10, max: 5000),
      'revenue': generatePrice(min: 100000, max: 10000000),
      'location': '${_faker.address.city()}, ${_faker.address.country()}',
    };
  }

  Map<String, dynamic> generateUserData() {
    return {
      'name': _faker.name.fullName(),
      'email': _faker.internet.email(),
      'role': randomArrayElement(['Admin', 'Manager', 'User', 'Viewer']),
      'department': _faker.commerce.department(),
      'status': randomArrayElement(['active', 'inactive', 'pending']),
    };
  }

  Map<String, dynamic> generateReportData() {
    final types = [
      'financial',
      'performance',
      'audit',
      'analytics',
      'compliance',
    ];
    return {
      'title': '${_faker.commerce.productName()} Report',
      'type': randomArrayElement(types),
      'status': randomArrayElement([
        'draft',
        'in_progress',
        'completed',
        'published',
      ]),
      'completion': _faker.datatype.number(min: 0, max: 100),
    };
  }

  String formatDate(DateTime date, {bool includeTime = false}) {
    if (includeTime) {
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    }
    return '${date.day}/${date.month}/${date.year}';
  }

  String timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '${months}mo ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '${years}y ago';
    }
  }

  String generateColorFromText(String text) {
    final colors = [
      '#FF6B6B',
      '#4ECDC4',
      '#45B7D1',
      '#96CEB4',
      '#FFEAA7',
      '#DDA0DD',
      '#98D8C8',
      '#F7DC6F',
      '#BB8FCE',
      '#85C1E9',
      '#F8C471',
      '#82E0AA',
      '#F1948A',
      '#85C1E9',
      '#D7BDE2',
    ];

    final hash = text.codeUnits.fold(0, (int acc, int unit) => acc + unit);
    return colors[hash % colors.length];
  }

  String generateInitials(String name) {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (name.isNotEmpty) {
      return name.substring(0, 1).toUpperCase();
    }
    return 'U';
  }

  String generateDescription({int sentenceCount = 2}) {
    return _faker.lorem.paragraph(sentenceCount: sentenceCount);
  }

  List<String> generateTags(String category, {int count = 3}) {
    final tagMap = {
      'technology': [
        'AI',
        'Machine Learning',
        'Cloud',
        'Mobile',
        'Web',
        'Data Science',
      ],
      'finance': [
        'Investment',
        'Banking',
        'Stocks',
        'Crypto',
        'Wealth',
        'Trading',
      ],
      'healthcare': [
        'Medical',
        'Pharma',
        'Wellness',
        'Research',
        'Patient Care',
      ],
      'education': [
        'Online Learning',
        'EdTech',
        'Courses',
        'Certification',
        'Training',
      ],
      'retail': [
        'E-commerce',
        'Customer Service',
        'Sales',
        'Marketing',
        'Logistics',
      ],
      'manufacturing': [
        'Production',
        'Supply Chain',
        'Quality Control',
        'Automation',
      ],
    };

    final tags =
        tagMap[category.toLowerCase()] ??
        ['General', 'Business', 'Corporate', 'Enterprise'];

    return randomArrayElements(tags, count: count);
  }
}
