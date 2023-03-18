import 'package:app_water/pages/MycityPage.dart';
import 'package:app_water/pages/ciudades_page.dart';
import 'package:app_water/pages/configuraciones_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_services.dart';
import '../services/request_service.dart';
import '../widgets/bottom_navigation_widget.dart';

class HomePage extends StatelessWidget {
  List pages = [MycityPage(), CiudadesPage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
        checkConection(context,false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
          child: pages[authService.pagesBottom],
        ),
        bottomNavigationBar: BottomNavigationWidget((value) {
          authService.pagesBottom = value;
        }));
  }
}
