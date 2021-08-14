import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_database_project/hive_box/boxes.dart';

import '../constants/constants.dart';
import '../model/contact_model.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({Key? key}) : super(key: key);

  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  List<ContactModel> contactList = [];

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
                  Card(
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
                  Expanded(
                    child: ListView.builder(
                      itemCount: contactList.length,
                      itemBuilder: (context, index) {
                        final contact = contactList[index];
                        return ListTile(
                          title: Text(contact.name),
                          subtitle: Text(contact.email),
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
