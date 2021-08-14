import '../hive_box/boxes.dart';
import '../model/contact_model.dart';

class HiveServiceForContactModel {
  Future<void> addContact({
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
    // await box.put("contactList", contactModel);
    await box.add(contactModel);
  }

  Future<void> editContact({
    required ContactModel oldContact,
    required String name,
    String? email,
    required String phone,
    required bool isFav,
  }) async {
    oldContact
      ..name = name
      ..phone = int.parse(phone)
      ..email = email
      ..isFavourite = isFav;

    await oldContact.save();
  }

  Future<void> deleteContact({required ContactModel oldContact}) async {
    await oldContact.delete();
  }
}
