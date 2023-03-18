import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../services/request_service.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  late StreamSubscription<bool> escuchador;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
          future: checkGpsYLocation(context),
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(80.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Center(child: CircularProgressIndicator())],
              ),
            );
          }),
    );
  }


  Future checkGpsYLocation(BuildContext context) async {
    final permisonGPS = await Permission.location.isGranted;

    if (!permisonGPS) {
      Navigator.pushReplacementNamed(context, 'AcessoGpsPage');
      return 'Es necesario el permiso de GPS';
    }
    await checkConection(context,true);
  }
}

  