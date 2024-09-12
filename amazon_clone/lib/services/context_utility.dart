import 'package:flutter/material.dart';

class ContextUtility {
  static final GlobalKey<NavigatorState> _navigatorkey= GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> get navigatorkey => _navigatorkey;
  static NavigatorState? get navigator => navigatorkey.currentState;
  
  static BuildContext? get context => navigator?.overlay?.context;

}