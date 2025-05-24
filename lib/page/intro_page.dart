import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pokemonworld/common/app_theme/theme.dart';
import 'package:pokemonworld/common/routes/routes.dart';
import 'package:pokemonworld/common/utils/utils.dart';
import 'package:get/get.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColorLight1,
      body: Center(
        child: Animate(
          child: Text(
            "Pokemon World",
            style: Utils.appBoldTextStyle,
          ).animate().fade(duration: 500.ms).scale(delay: 500.ms).shimmer(duration: 2000.ms, color: AppTheme.secondaryContainerColorLight),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        backgroundColor: AppTheme.darkFillColor,
        onPressed: () {
          Get.offAllNamed(Routes.home);
        },
        child: Icon(Icons.arrow_forward_ios, color: AppTheme.lightFillColor),
      ),
    );
  }
}
