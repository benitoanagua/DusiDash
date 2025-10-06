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
}
