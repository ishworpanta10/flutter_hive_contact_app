import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'constants/constants.dart';
import 'screen/homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<bool>(ThemeBox);
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<bool>(ThemeBox).listenable(),
      builder: (context, Box box, widget) {
        final bool isDark = box.get(IsDarkKey, defaultValue: false);
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          darkTheme: ThemeData.dark(),
          home: HomePage(),
        );
      },
    );
  }
}
