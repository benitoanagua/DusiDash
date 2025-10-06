class User {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String role;
  final String company;
  final String department;
  final String avatar;
  final String status;
  final DateTime joinDate;
  final DateTime lastLogin;
  final List<String> permissions;
  final Map<String, dynamic> metadata;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.role,
    required this.company,
    required this.department,
    required this.avatar,
    required this.status,
    required this.joinDate,
    required this.lastLogin,
    required this.permissions,
    required this.metadata,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      company: json['company'],
      department: json['department'],
      avatar: json['avatar'],
      status: json['status'],
      joinDate: DateTime.parse(json['joinDate']),
      lastLogin: DateTime.parse(json['lastLogin']),
      permissions: List<String>.from(json['permissions']),
      metadata: Map<String, dynamic>.from(json['metadata']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'company': company,
      'department': department,
      'avatar': avatar,
      'status': status,
      'joinDate': joinDate.toIso8601String(),
      'lastLogin': lastLogin.toIso8601String(),
      'permissions': permissions,
      'metadata': metadata,
    };
  }

  String get lastActiveFormatted {
    final now = DateTime.now();
    final difference = now.difference(lastLogin);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  bool get isActive => status == 'active';
  bool get isAdmin => role.toLowerCase() == 'admin';
}
