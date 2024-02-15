import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

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
              height: deviceH <= 750 ? 40 : 80,
            ),
            SvgPicture.asset(
              'assets/intro_2.svg',
              height: deviceH <= 750 ? 300 : 350,
            ),
            SizedBox(
              height: deviceH <= 750 ? 30 : 30,
            ),
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'Take control of your \n',
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: 'routine ',
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const TextSpan(
                      text: 'here with ease. \n',
                    ),
                    TextSpan(
                      text: 'Track ',
                      style: GoogleFonts.raleway(
                        color: Colors.green.shade400,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const TextSpan(
                      text: 'and manage your ',
                    ),
                    TextSpan(
                      text: 'habits ',
                      style: GoogleFonts.raleway(
                        color: Colors.green.shade400,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const TextSpan(
                      text: 'with us. ',
                    ),
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
