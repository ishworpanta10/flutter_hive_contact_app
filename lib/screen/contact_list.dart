import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_database_project/constants/constants.dart';

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
    return contactList.isEmpty
        ? const Center(
            child: Text('No Contact Yet'),
          )
        : Container();
  }
}
