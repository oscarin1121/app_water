import 'package:app_water/pages/acceso_gps_page.dart';
import 'package:app_water/pages/ciudades_page.dart';
import 'package:app_water/pages/configuraciones_page.dart';
import 'package:app_water/pages/home_page.dart';
import 'package:app_water/pages/splash_screen.dart';
import 'package:app_water/services/auth_services.dart';
import 'package:app_water/shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_ES', null);
  SharedPreferencesUser prefs = new SharedPreferencesUser();
  await prefs.initPrefs();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (_) => AuthService()),
         ChangeNotifierProvider(create: (_) => AuthServiceEdit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        
        routes: {
          'HomePage': (_) => HomePage(),
          'CiudadesPages': (_) => CiudadesPage(),
          'SettingsPage': (_) => SettingsPage(),
          'AcessoGpsPage': (_) => AccesoGPSPage(),
          'SplashScreen': (_) => SplashScreenPage(),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "SplashScreen",
      ),
    );
  }
}
