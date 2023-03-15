import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:rhitmo_list/controllers/auth_controller.dart';
import 'package:rhitmo_list/ui/home_page.dart';
import 'package:rhitmo_list/ui/add_todo_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rhitmo_list/ui/login_page.dart';
import 'package:rhitmo_list/ui/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rhitmo_list/ui/splash_page.dart';
import 'firebase_options.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

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
      theme: ThemeData(
          primarySwatch: const MaterialColor(0xFF0A0A3A, {
        50: Color(0xFF0A0A3A),
        100: Color(0xFF0A0A3A),
        200: Color(0xFF0A0A3A),
        300: Color(0xFF0A0A3A),
        400: Color(0xFF0A0A3A),
        500: Color(0xFF0A0A3A),
        600: Color(0xFF0A0A3A),
        700: Color(0xFF0A0A3A),
        800: Color(0xFF0A0A3A),
        900: Color(0xFF0A0A3A),
      })),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      title: title,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashPage.id,
      getPages: [
        GetPage(name: SplashPage.id, page: () => SplashPage()),
        GetPage(name: LoginPage.id, page: () => LoginPage()),
        GetPage(name: RegisterPage.id, page: () => RegisterPage()),
        GetPage(name: AddTodoPage.id, page: () => AddTodoPage()),
        GetPage(name: HomePage.id, page: () => HomePage()),
      ],
    );
  }
}
