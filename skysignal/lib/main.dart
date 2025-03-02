import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:skysignal/firebase_options.dart';
import 'package:skysignal/provider/internet_connection_check_provider.dart';
import 'package:skysignal/provider/theme_provider.dart';
import 'package:skysignal/screens/main_screen.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context)=>InternetConnectionCheckProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return GetMaterialApp(

            title: 'SkySignal',
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.changeTheme,

            theme: ThemeData(
              primaryColor: Colors.cyan,
              brightness: Brightness.light,
            ),

            darkTheme: ThemeData(
              primaryColor: Colors.teal,
              brightness: Brightness.dark,
            ),

            home: const MainScreen(),

          );
        },
      ),
    );
  }
}
