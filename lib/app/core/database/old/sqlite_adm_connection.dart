// import 'package:flutter/material.dart';
// import 'package:mechanic_app/app/core/database/sqlite_connection_factory.dart';

// class SqliteAdmConnection with WidgetsBindingObserver {
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     final connection = SqliteConnectionFactory();

//     switch (state) {
//       case AppLifecycleState.resumed:
//         break;
//       case AppLifecycleState.detached:
//       case AppLifecycleState.hidden:
//       case AppLifecycleState.inactive:
//       case AppLifecycleState.paused:
//         connection.closeConnection();
//         break;
//     }

//     super.didChangeAppLifecycleState(state);
//   }
// }