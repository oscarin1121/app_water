import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier {
  int _pagesBottom = 0;
  bool _addCity = false;
  set pagesBottom(int valor) {
    this._pagesBottom = valor;
    notifyListeners();
  }

 int get pagesBottom => this._pagesBottom;

  set addCity(bool valor) {
    this._addCity = !this._addCity;
    notifyListeners();
  }

 bool get addCity => this._addCity;
}
class AuthServiceEdit extends ChangeNotifier {

  bool _editItems = false;
  
  set editItems(bool valor) {
    this._editItems = !this._editItems;
    notifyListeners();
  }

 bool get editItems => this._editItems;
}
