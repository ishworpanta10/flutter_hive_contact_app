import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_database_project/services/hive_services_for_contact_model.dart';

import '../constants/constants.dart';
import 'contact_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _phoneController = TextEditingController();

  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    print("=====Widget Rebuild ========");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hive Basic"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          ValueListenableBuilder(
            valueListenable: Hive.box<bool>(ThemeBox).listenable(),
            builder: (context, Box box, widget) {
              final bool isDark = box.get(IsDarkKey);
              return SwitchListTile(
                value: isDark,
                onChanged: (value) {
                  box.put(IsDarkKey, !isDark);
                },
                title: const Text('Toggle Theme'),
              );
            },
          ),
          const SizedBox(height: 10),
          const Expanded(
            child: ContactListPage(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: _showAlert,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  AlertDialog _showAlert(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Contact"),
      content: StatefulBuilder(
        builder: (context, setState) => Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: (value) {
                  return value!.trim().isEmpty ? "Name cannot be empty" : null;
                },
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: "name",
                ),
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: "email",
                ),
              ),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "phone",
                ),
                validator: (value) {
                  return value!.trim().isEmpty || int.parse(value).isNaN ? "Invalid phone number" : null;
                },
              ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Is Favourite'),
                value: isFavourite,
                onChanged: (value) {
                  setState(() {
                    isFavourite = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _addContact,
          child: const Text("Add"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            clearAllController();
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }

  void _addContact() {
    if (_formKey.currentState!.validate()) {
      HiveServiceForContactModel().addContact(
        name: _nameController.text,
        phone: _phoneController.text,
        email: _emailController.text,
        isFav: isFavourite,
      );
      Navigator.pop(context);
      clearAllController();
    }
  }

  void clearAllController() {
    _phoneController.clear();
    _nameController.clear();
    _emailController.clear();
    isFavourite = false;
  }
}
