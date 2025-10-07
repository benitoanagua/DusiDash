class Company {
  final String id;
  final String name;
  final String industry;
  final String size;
  final DateTime founded;
  final double revenue;
  final int employees;
  final String location;
  final String website;
  final String description;
  final ContactInfo contact;
  final List<String> tags;

  Company({
    required this.id,
    required this.name,
    required this.industry,
    required this.size,
    required this.founded,
    required this.revenue,
    required this.employees,
    required this.location,
    required this.website,
    required this.description,
    required this.contact,
    required this.tags,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'],
      industry: json['industry'],
      size: json['size'],
      founded: DateTime.parse(json['founded']),
      revenue: json['revenue'].toDouble(),
      employees: json['employees'],
      location: json['location'],
      website: json['website'],
      description: json['description'],
      contact: ContactInfo.fromJson(json['contact']),
      tags: List<String>.from(json['tags']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'industry': industry,
      'size': size,
      'founded': founded.toIso8601String(),
      'revenue': revenue,
      'employees': employees,
      'location': location,
      'website': website,
      'description': description,
      'contact': contact.toJson(),
      'tags': tags,
    };
  }
}

class ContactInfo {
  final String email;
  final String phone;
  final String address;

  ContactInfo({
    required this.email,
    required this.phone,
    required this.address,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'phone': phone, 'address': address};
  }
}
