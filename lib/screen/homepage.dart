import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/constants.dart';
import 'contact_list.dart';

class HomePage extends StatelessWidget {
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
            builder: (context) => _showAlert(context),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  AlertDialog _showAlert(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Contact"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              hintText: "name",
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: "email",
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: "phone",
            ),
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Is Favourite'),
            value: false,
            onChanged: (value) {},
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text("Add"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
