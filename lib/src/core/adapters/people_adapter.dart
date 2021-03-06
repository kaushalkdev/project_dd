import 'package:hive/hive.dart';

part 'people_adapter.g.dart';

@HiveType(typeId: 0)
class People extends HiveObject {
  @HiveField(0)
  late String uuid;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late DateTime dateTime;
  @HiveField(3)
  late String location;
  @HiveField(4)
  late String gender;
  @HiveField(5)
  late Map<String, dynamic> general = {};
  @HiveField(6)
  late Map<String, dynamic> economy = {};
  @HiveField(7)
  late Map<String, dynamic> education = {};
  @HiveField(8)
  late Map<String, dynamic> governmentSchemes = {};
  @HiveField(9)
  late Map<String, dynamic> health = {};
  @HiveField(10)
  late Map<String, dynamic> modernization = {};
  @HiveField(11)
  late Map<String, dynamic> social = {};
}
