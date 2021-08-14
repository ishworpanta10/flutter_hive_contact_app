import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/constants.dart';

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
        ],
      ),
    );
  }
}
