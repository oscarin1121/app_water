import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../model/model_units.dart';
import '../services/auth_services.dart';
import '../shared_preferences/shared_preferences.dart';
import 'default_button.dart';

class PinterestGrid extends StatelessWidget {
  final List<dynamic>? items;
  final bool searchItem;

  PinterestGrid({super.key, this.items, this.searchItem = false});

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      // padding: EdgeInsets.symmetric(vertical: 10),
      gridDelegate: SliverWovenGridDelegate.count(
        crossAxisCount: 2,
        pattern: [
          // WovenGridTile(1),
          WovenGridTile(
            5 / 7,
            crossAxisRatio: 0.9,
            alignment: AlignmentDirectional.center,
          ),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
          (context, index) => _PinterestItem(
                item: items![index],
                searchItem: searchItem,
              ),
          childCount: items?.length),
    );
  }
}

class PinterestGridHorizontal extends StatelessWidget {
  final List<dynamic>? items;
  final bool searchItem;

  PinterestGridHorizontal({super.key, this.items, this.searchItem = false});

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      scrollDirection: Axis.horizontal,
      // padding: EdgeInsets.symmetric(vertical: 10),
      gridDelegate: SliverWovenGridDelegate.count(
        crossAxisCount: 1,
        pattern: [
          // WovenGridTile(1),
          WovenGridTile(
            5 / 5,
            crossAxisRatio: 0.9,
            alignment: AlignmentDirectional.center,
          ),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
          (context, index) => _PinterestItem(
                item: items![index],
                searchItem: searchItem,
              ),
          childCount: items?.length),
    );
  }
}

class _PinterestItem extends StatefulWidget {
  dynamic item;
  final bool searchItem;

  _PinterestItem({Key? key, required this.item, this.searchItem = false})
      : super(key: key);

  @override
  State<_PinterestItem> createState() => _PinterestItemState();
}

class _PinterestItemState extends State<_PinterestItem> {
  SharedPreferencesUser prefs = new SharedPreferencesUser();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authServiceEdit = Provider.of<AuthServiceEdit>(context);
    bool checkItem = prefs.listCitys!
        .contains("${widget.item.name}-${widget.item.sys.country}");
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${widget.item.main.temp?.toStringAsFixed(0)} ${UnidadesMedida().temperatura}",
                      style: TextStyle(fontSize: 23, color: Colors.black),
                    ),
                    Text(
                      "${widget.item.name}",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    Text(
                      "${widget.item.sys.country}",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.water_drop_outlined),
                            Text(
                              "${widget.item.main.humidity}%",
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.air_rounded),
                            Text(
                              "${widget.item.wind.speed} ${UnidadesMedida().velocidadViento}",
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ],
                    ),
                    widget.searchItem
                        ? DefaultButton(
                            size: size,
                            childButton: Text(
                              checkItem ? "Agregado" : "Agregar Ciudad",
                              style: TextStyle(color: Colors.black),
                            ),
                            colorButton:
                                checkItem ? Colors.grey : Color(0xffFFBB7C),
                            function: checkItem
                                ? null
                                : () {
                                    final listaCiudades = prefs.listCitys;
                                    listaCiudades!.add(
                                        "${widget.item.name}-${widget.item.sys.country}");
                                    prefs.listCitys = listaCiudades;
                                    setState(() {});
                                  },
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          ),
        ),
        authServiceEdit.editItems
            ? Positioned(
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    SharedPreferencesUser prefs = new SharedPreferencesUser();
                    final listaCytis = prefs.listCitys;
                    listaCytis?.removeWhere((item) =>
                        item ==
                        '${widget.item.name}-${widget.item.sys.country}');
                    print('${widget.item.name}-${widget.item.sys.country}');
                    prefs.listCitys = listaCytis;
                    print('${prefs.listCitys}');
                    final authService =
                        Provider.of<AuthService>(context, listen: false);
                    authService.addCity = true;
                  },
                  child: Container(
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24.0,
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
