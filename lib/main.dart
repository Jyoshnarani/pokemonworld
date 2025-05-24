import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:pokemonworld/page/detail_page.dart';
import 'package:pokemonworld/page/home_list_page.dart';
import 'package:pokemonworld/page/intro_page.dart';

import 'common/routes/routes.dart';

void main() {
  runApp(
    GetMaterialApp(
      initialRoute: Routes.intro,
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
      getPages: [
        GetPage(name: Routes.intro, page: () => IntroPage()),
        GetPage(name: Routes.home, page: () => HomePage()),
        GetPage(name: Routes.details, page: () => DetailPage()),
      ],
    ),
  );
}
