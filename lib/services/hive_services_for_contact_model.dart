import 'package:local_database_project/hive_box/boxes.dart';

import '../model/contact_model.dart';

class HiveServiceForContactModel {
  Future addContact({
    required String name,
    String? email,
    required String phone,
    required bool isFav,
  }) async {
    final contactModel = ContactModel()
      ..name = name
      ..email = email ?? ""
      ..phone = int.parse(phone)
      ..isFavourite = isFav
      ..createdDate = DateTime.now();

    //getting box list
    final box = Boxes.getContactBox();
    //we can put key value also as
    // await box.put("contactList", contactModel);
    await box.add(contactModel);

    //  now  In setState and adding this contact in local contact list variable
  }
}
