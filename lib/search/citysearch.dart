
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/find_city_model.dart';
import '../widgets/pinterest_grid_widget.dart';

class CitySearchDelegate extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => "Ingresa el nombre de la ciudad";

  Future<List<ListElement>> _fetchCityList(String query) async {
    final response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/find?q=$query&type=like&mode=json&appid=f99b06fca9d39762a8d9863bb129678c'));

    final responseData = findCityModelFromJson(response.body);

    return responseData.list;
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      colorScheme: ColorScheme(
        primary: Color(0xffFFBB7C),
        secondary: Colors.orange,
        background: Color(0xffFFBB7C),
        surface: Color(0xffFFBB7C),
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: Colors.black,
        onSurface: Colors.black,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white54),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text("Searching..."),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty || query.length < 3) {
      return Container();
    }

    return FutureBuilder(
      future: _fetchCityList(query),
      builder:
          (BuildContext context, AsyncSnapshot<List<ListElement>> snapshot) {
        if (snapshot.hasData) {
          final cityList = snapshot.data;
          return PinterestGrid(
            items: cityList,
            searchItem: true,
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}


