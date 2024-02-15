import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceH = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: deviceH <= 750 ? 20 : 80,
            ),
            SvgPicture.asset(
              'assets/intro_1.svg',
              height: deviceH <= 750 ? 300 : 350,
            ),
            SizedBox(
              height: deviceH <= 750 ? 12 : 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text.rich(
                TextSpan(
                  text: 'Welcome!',
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontSize: 45,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'Build ',
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: 'positive habits,  \n',
                      style: GoogleFonts.raleway(
                        color: Colors.green.shade400,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const TextSpan(
                      text: 'transform your life. \n',
                    ),
                    const TextSpan(
                      text: 'Start now with ',
                    ),
                    TextSpan(
                      text: 'Habit Tracker!',
                      style: GoogleFonts.raleway(
                        color: Colors.green.shade400,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
