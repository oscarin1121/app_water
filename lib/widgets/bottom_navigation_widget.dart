import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavigationWidget extends StatelessWidget {
  
  Function(int)? function;

  BottomNavigationWidget(this.function);

  @override
  Widget build(BuildContext context) {
    return GNav(
        // backgroundColor: Colors.red,
        tabActiveBorder: Border.all(color: Colors.black, width: 1),
        duration: Duration(milliseconds: 900),
        onTabChange: function,
        padding: EdgeInsets.all(5),
        tabMargin: EdgeInsets.fromLTRB(25, 12, 25, 12),
        gap: 8,
        activeColor: Colors.black,
        color: Colors.grey,
        tabs: [
          GButton(
            icon: Icons.home,
            text: "Inicio",
          ),
          GButton(
            icon: Icons.favorite_border,
            text: "Ciudades",
          ),
          GButton(
            icon: Icons.settings,
            text: "Configuraciones",
          )
        ]);
  }
}
