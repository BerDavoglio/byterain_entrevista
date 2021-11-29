import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../infra/infra.dart';
import '../ui/ui.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Color.fromRGBO(170, 60, 255, 1);
    final primaryColorDark = Color.fromRGBO(170, 50, 220, 1);
    final primaryColorLight = Color.fromRGBO(170, 130, 255, 1);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ContactProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'ByteRain Contacts',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: primaryColor,
          primaryColorDark: primaryColorDark,
          primaryColorLight: primaryColorLight,
          accentColor: primaryColor,
          backgroundColor: Colors.amber[100],
        ),
        routes: {
          AppRoutes.HOME: (_) => HomePage(),
          AppRoutes.CRUD: (_) => CreateUpdatePage(),
        },
      ),
    );
  }
}
