import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/presentation/pages/home_page.dart';
import 'package:habit_tracker/presentation/pages/onboarding_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  final bool firstLaunch;
  const SplashScreen({super.key, required this.firstLaunch});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/splash.json'),
      pageTransitionType: PageTransitionType.fade,
      splashTransition: SplashTransition.fadeTransition,
      duration: 4100,
      backgroundColor: const Color.fromRGBO(228, 240, 246, 1),
      splashIconSize: 80000,
      nextScreen:
          firstLaunch == true ? const OnBoardingScreen() : const HomePage(),
    );
  }
}
