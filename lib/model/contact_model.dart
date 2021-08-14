import 'package:hive/hive.dart';

part 'contact_model.g.dart';

@HiveType(typeId: 0)
class ContactModel extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String email;

  @HiveField(2)
  late int phone;

  @HiveField(3)
  late DateTime createdDate;

  @HiveField(4)
  late bool isFavourite = false;

// command =>  flutter packages pub run build_runner build
}
