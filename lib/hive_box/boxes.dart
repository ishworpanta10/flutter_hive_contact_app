import 'package:hive_flutter/hive_flutter.dart';

import '../constants/constants.dart';
import '../model/contact_model.dart';

class Boxes {
  static Box<ContactModel> getContactBox() => Hive.box<ContactModel>(ContactBox);
}
