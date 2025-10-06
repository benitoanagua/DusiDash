import 'package:faker_dart/faker_dart.dart';

class FakerService {
  static final FakerService _instance = FakerService._internal();
  final Faker _faker = Faker.instance;

  factory FakerService() => _instance;

  FakerService._internal();

  Faker get faker => _faker;

  T randomArrayElement<T>(List<T> list) {
    return _faker.datatype.number(max: list.length - 1) < list.length
        ? list[_faker.datatype.number(max: list.length - 1)]
        : list.first;
  }

  List<T> randomArrayElements<T>(List<T> list, {int count = 1}) {
    final shuffled = List<T>.from(list)..shuffle();
    return shuffled.take(count).toList();
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
}
