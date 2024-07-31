import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class CustomerDetailHiveModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String panNumber;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String mobile;

  @HiveField(4)
  final String email;

  @HiveField(5)
  final String addressLine1;

  @HiveField(6)
  final String addressLine2;

  @HiveField(7)
  final String postalCode;

  @HiveField(9)
  final List<String> state;

  @HiveField(10)
  final List<String> city;

  CustomerDetailHiveModel({
    required this.id,
    required this.panNumber,
    required this.name,
    required this.mobile,
    required this.email,
    required this.city,
    required this.state,
    required this.addressLine1,
    required this.addressLine2,
    required this.postalCode,
  });
}
