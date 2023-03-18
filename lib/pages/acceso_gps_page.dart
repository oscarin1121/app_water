import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AccesoGPSPage extends StatefulWidget {
  @override
  _AccesoGPSPageState createState() => _AccesoGPSPageState();
}

class _AccesoGPSPageState extends State<AccesoGPSPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (mounted) {
        if (await Permission.location.isGranted) {
          // Navigator.pushReplacementNamed(context, 'home_clientes');  
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Color morado = Color.fromRGBO(179, 91, 214, 1);
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Card(
                  elevation: 10.0,
                  child: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      'Es necesario activar el Gps para tener una mejor experiencia de la aplicacion',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  'De click en el boton para permitir acceso de ubicacion',
                  textAlign: TextAlign.center,
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  final status = await Permission.location.request();

                  accesoGPS(status);
                },
                child: Text(
                  'Permitir',
                  style: TextStyle(color: Colors.white),
                ),
                color: morado,
                shape: const StadiumBorder(),
                elevation: 0,
                splashColor: Colors.transparent,
              )
            ],
          ),
        ));
  }

  void accesoGPS(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        if (mounted) {
          Navigator.pushReplacementNamed(context, 'HomePage');
        }
        break;

      case PermissionStatus.limited:
      case PermissionStatus.restricted:
      case PermissionStatus.denied:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
    }
  }
}
