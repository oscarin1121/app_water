import 'package:app_water/services/request_service.dart';
import 'package:flutter/material.dart';


import 'package:provider/provider.dart';
import '../search/citysearch.dart';
import '../services/auth_services.dart';

import '../widgets/pinterest_grid_widget.dart';

class CiudadesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: FutureBuilder(
            initialData: [],
            future: searchCitys(),
            builder: (context, snapshot) {
              if (!snapshot.hasData ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
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
                    _SearchWidget(),
                    Expanded(
                      child: PinterestGrid(
                        items: cityList,
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class _ButtonEditWidget extends StatelessWidget {
  const _ButtonEditWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authServiceEdit = Provider.of<AuthServiceEdit>(context);
    return Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: authServiceEdit.editItems ? Colors.green : Colors.white,
            shape: BoxShape.circle),
        child: IconButton(
          onPressed: () {
            authServiceEdit.editItems = true;
          },
          icon: Icon(
            Icons.mode_edit_outlined,
            color: authServiceEdit.editItems ? Colors.white : Colors.black,
          ),
        ));
  }
}

class _SearchWidget extends StatelessWidget {
  const _SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () async {
              final cityName = await showSearch(
                context: context,
                delegate: CitySearchDelegate(),
              );
              authService.addCity = true;
            },
            child: Container(
              width: size.width * 0.70,
              height: size.height * 0.065,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.white),
              child:const ListTile(
                leading: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                title: Text("Agregar ciudad"),
              ),
            ),
          ),
          _ButtonEditWidget()
        ],
      ),
    );
  }
}
