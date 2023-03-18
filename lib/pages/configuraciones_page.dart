
import 'package:flutter/material.dart';
import '../shared_preferences/shared_preferences.dart';


class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(child: buttomSelectConfig()),
      ),
    );
  }
}

class buttomSelectConfig extends StatelessWidget {
  const buttomSelectConfig({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: size.height * 0.065,
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ConfigSelect()],
          ),
        ),
      ),
    );
  }
}

class ConfigSelect extends StatefulWidget {
  ConfigSelect({
    super.key,
  });

  @override
  State<ConfigSelect> createState() => _ConfigSelectState();
}

class _ConfigSelectState extends State<ConfigSelect> {
  final List<String> elementos = ['standard', 'metric', 'imperial'];
  SharedPreferencesUser prefs = new SharedPreferencesUser();
  @override
  Widget build(BuildContext context) {
    Icon icon =const Icon(
      Icons.arrow_forward_ios_outlined,
      color: Colors.black,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
       const Text(
          "Unidades de medida",
          style: TextStyle(color: Colors.black),
        ),
        DropdownButton(
          value: prefs.UnidadesMedida,
          items: elementos.map((String elemento) {
            return DropdownMenuItem<String>(
              value: elemento,
              child: Text(elemento),
            );
          }).toList(),
          onChanged: (String? nuevoElementoSeleccionado) {
            prefs.UnidadesMedida = nuevoElementoSeleccionado!;
            setState(() {});
          },
        )
      ],
    );
  }
}
