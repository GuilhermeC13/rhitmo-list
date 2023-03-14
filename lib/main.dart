import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:rhitmo_list/ui/home_page.dart';
import 'package:rhitmo_list/ui/add_todo_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rhitmo_list/ui/login_page.dart';
import 'package:rhitmo_list/ui/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      initialRoute: LoginPage.id,
      getPages: [
        GetPage(name: LoginPage.id, page: () => LoginPage()),
        GetPage(name: RegisterPage.id, page: () => RegisterPage()),
        GetPage(name: AddTodoPage.id, page: () => AddTodoPage()),
        GetPage(name: HomePage.id, page: () => HomePage()),
      ],
    );
  }
}
