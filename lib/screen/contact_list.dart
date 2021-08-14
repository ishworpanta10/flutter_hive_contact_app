import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/constants.dart';
import '../hive_box/boxes.dart';
import '../model/contact_model.dart';
import 'widget/single_contact_tile.dart';

class ContactListPage extends StatefulWidget {
  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  @override
  void dispose() {
    Hive.box(ContactBox).close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<ContactModel>>(
      valueListenable: Boxes.getContactBox().listenable(),
      builder: (context, box, widget) {
        final contactList = box.values.toList().cast<ContactModel>();
        return contactList.isEmpty
            ? const Center(
                child: Text('No Contact Yet'),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 8,
                    ),
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Contact List',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: contactList.length,
                      itemBuilder: (context, index) {
                        final contact = contactList[index];
                        // print("Contact Name : ${contact.name}");
                        return SingleContactTile(
                          contact: contact,
                        );
                      },
                    ),
                  ),
                ],
              );
      },
    );
  }
}
