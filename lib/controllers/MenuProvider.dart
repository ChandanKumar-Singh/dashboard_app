import 'package:flutter/material.dart';

import '../responsive.dart';

class MenuProvider extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void controlMenu(BuildContext context) {
    if (!_scaffoldKey.currentState!.isDrawerOpen &&
        !Responsive.isDesktop(context)) {
      _scaffoldKey.currentState!.openDrawer();
    } else {
      _scaffoldKey.currentState!.closeDrawer();
    }
  }

  String sideMenu = 'Dashboard';
  setSideMenu(String? val) {
    sideMenu = val ?? 'Dashboard';
    notifyListeners();
  }

  List<String> headerContent = [
    'overview',
    'account',
    'activities',
    'spending',
    'addresses',
    'additional'
  ];
  int section = 0;
  setSection(int val) {
    section = val;
    notifyListeners();
  }
}
