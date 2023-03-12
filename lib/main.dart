import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:rhitmo_list/ui/home_page.dart';
import 'package:rhitmo_list/ui/add_todo_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Getx Todo';

  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      title: title,
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.id,
      getPages: [
        GetPage(name: AddTodoPage.id, page: () => AddTodoPage()),
        GetPage(name: HomePage.id, page: () => HomePage()),
      ],
    );
  }
}
