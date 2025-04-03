// import 'package:flutter/material.dart';

// import 'screen/start_up_screen/start_up_screen.dart';

// RouteFactory routeFactory = (settings) {
//   final uri = Uri.parse(settings.name ?? StartUpScreen.route());
//   final int? sound = int.tryParse(uri.queryParameters[StartUpScreenParamKey.sound] ?? '');
//   final int? mode = int.tryParse(uri.queryParameters[StartUpScreenParamKey.mode] ?? '');
//   final int? level = int.tryParse(uri.queryParameters[StartUpScreenParamKey.level] ?? '');

//   switch (uri.path) {
//     case StartUpScreen.route:
//       return MaterialPageRoute(
//         builder: (context) => StartUpScreen(sound: sound, mode: mode, level: level),
//       );
//     default:
//       return MaterialPageRoute(
//         builder: (context) => StartUpScreen(sound: sound, mode: mode, level: level),
//       );
//   }
// };

// String createRoute(
//   String route,
//   Map<String, dynamic> params,
// ) {
//   params.removeWhere((_, value) => value == null);
//   return '$route${params.isNotEmpty ? '?' : ''}${params.entries.map((e) => '${e.key}=${e.value}').join('&')}';
// }
