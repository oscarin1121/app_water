import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/forecast_model.dart';
import '../model/model_units.dart';
import '../services/request_service.dart';
import '../shared_preferences/shared_preferences.dart';
import '../widgets/circle_home_widget.dart';
import '../widgets/circle_widget.dart';
import '../widgets/cloud_widget.dart';
import '../widgets/cloud_widget_prueba.dart';
import '../widgets/pinterest_grid_widget.dart';

class MycityPage extends StatelessWidget {
  MycityPage({
    super.key,
  });
  SharedPreferencesUser prefs = new SharedPreferencesUser();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: weatherRequest(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == false) {
            return Center(
                child: Text("Error en la solicitud marca al administrador"));
          }
          return Stack(
            children: [
              CircleHomeWidget(),
              prefs.weatherData?.weather[0].main == "Clouds"
                  ? CloudAnimation(size: size)
                  : Container(),
              ContainHomeWidget(size: size),
            ],
          );
        });
  }
}

class ContainHomeWidget extends StatelessWidget {
  const ContainHomeWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TopWidget(size),
          CenterTopWidget(),
          CenterHomeWidget(
            size: size,
            day: DateTime.now().day,
          ),
          const Center(
              child: Text(
            "Ciudades Seleccionadas",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          )),
          CitysWidgetHome(size: size),
        ],
      ),
    );
  }
}

class CitysWidgetHome extends StatelessWidget {
  const CitysWidgetHome({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.25,
      child: FutureBuilder(
          initialData: [],
          future: searchCitys(),
          builder: (context, snapshot) {
        
            if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            final cityList = snapshot.data;
            return Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Column(
                children: [
                  Expanded(
                    child: PinterestGridHorizontal(
                      items: cityList,
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}

class CenterHomeWidget extends StatelessWidget {
  SharedPreferencesUser prefs = new SharedPreferencesUser();
  CenterHomeWidget({
    super.key,
    required this.size,
    required this.day,
  });

  final Size size;
  final int day;

  String dateToDayOfWeek(DateTime date) {
    return DateFormat('EEEEEE', 'es_ES').format(date);
  }

  @override
  Widget build(BuildContext context) {
    List<ListElement> listitems = prefs.forecastData!.list;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(35, 25, 15, 0),
          child: Text(
            "Hoy",
            style: TextStyle(fontSize: 18, color: Colors.grey[400]),
          ),
        ),
        Container(
          height: size.height * 0.15,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: listitems.length,
                itemBuilder: (context, index) {
                  if (listitems[index].dtTxt.day == day) {
                    return HourTempWidget(
                      size: size,
                      item: listitems[index],
                    );
                  }
                  return Container();
                }),
          ),
        ),
      ],
    );
  }
}

class HourTempWidget extends StatelessWidget {
  const HourTempWidget({
    super.key,
    required this.size,
    required this.item,
  });

  final Size size;
  final ListElement item;

  @override
  Widget build(BuildContext context) {
    final DateFormat hora12Format = DateFormat('h a');
    String hora12 = hora12Format.format(item.dtTxt);
    return Container(
      height: size.height * 0.15,
      width: size.width * 0.20,
      // color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${hora12}",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          Container(
            height: size.height * 0.05,
            width: size.width * 0.7,
            child: CloudyCappedWidget(item),
          ),
          Text(
            "${item.main.temp.toStringAsFixed(0)}°",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

class CloudyCappedWidget extends StatelessWidget {
  CloudyCappedWidget(
    this.item, {
    super.key,
  });
  ListElement item;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Center(child: CircleWidget(25, item.dtTxt.hour)),
        item.weather[0].main == "Clouds"
            ? Center(child: CloudWidgetPrueba(25))
            : Container()
      ],
    );
  }
}

class CenterTopWidget extends StatelessWidget {
  CenterTopWidget({
    super.key,
  });
  SharedPreferencesUser prefs = new SharedPreferencesUser();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
           const Icon(
              Icons.water_drop_outlined,
            ),
            Text("${prefs.weatherData?.main.humidity}%"),
          ],
        ),
        Row(
          children: [
            Image.asset(
              "assets/pressure.png",
              height: 25,
            ),
            Text(
                "${prefs.weatherData?.main.pressure} ${UnidadesMedida().presion}"),
          ],
        ),
        Row(
          children: [
         const   Icon(Icons.air_rounded),
            Text(
                "${prefs.weatherData?.wind.speed}  ${UnidadesMedida().velocidadViento}"),
          ],
        ),
      ],
    );
  }
}

class CloudAnimation extends StatelessWidget {
  const CloudAnimation({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: Container(
        width: size.width * 0.5,
        height: size.height * 0.3,
        child: Stack(
          children: [
            Positioned(
              right: size.width * 0.060,
              child: Container(
                  height: size.height * 0.45,
                  width: size.width * 0.45,
                  child: CloudWidget()),
            ),
            Positioned(
              right: -20,
              child: Container(
                  height: size.height * 0.2,
                  width: size.width * 0.2,
                  child: CloudWidget()),
            ),
          ],
        ),
      ),
    );
  }
}

class TopWidget extends StatelessWidget {
  Size size;
  TopWidget(
    this.size, {
    super.key,
  });
  SharedPreferencesUser prefs = new SharedPreferencesUser();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.35,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${prefs.weatherData?.name}",
                  style: TextStyle(fontSize: 23),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "${prefs.weatherData?.main.temp.toStringAsFixed(0)} ${UnidadesMedida().temperatura}",
                    style: TextStyle(fontSize: 36),
                  ),
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        color: Color(0xffF2EFEC),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "${prefs.weatherData?.weather[0].description}",
                      style: TextStyle(fontSize: 15),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
