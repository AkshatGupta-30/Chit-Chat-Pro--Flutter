import 'package:chit_chat_pro/src/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowy_borders/glowy_borders.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity, height: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey.shade900, Colors.grey.shade900.withOpacity(0.75)],
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
            tileMode: TileMode.clamp
          )
        ),
        child: GetBuilder(
          init: SplashController(),
          builder: (controller) {
            return FadeTransition(
              opacity: controller.scaleAnimation,
              child: AnimatedGradientBorder(
                gradientColors: [Colors.white, Colors.grey.shade300], borderSize: 0.25,
                borderRadius: BorderRadius.circular(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/launcher_icon/launcher400x400.png', width: MediaQuery.sizeOf(context).width/3.75,)
                ),
              ),
            );
          }
        )
      ),
    );
  }
}