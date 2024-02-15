import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/presentation/pages/home_page.dart';
import 'package:habit_tracker/presentation/pages/intro_page_1.dart';
import 'package:habit_tracker/presentation/pages/intro_page_2.dart';
import 'package:habit_tracker/presentation/pages/intro_page_3.dart';
import 'package:habit_tracker/utils/theme/dark_mode.dart';
import 'package:habit_tracker/utils/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  //Controller to kkep track of witch page we're on
  final _controller = PageController();

  //Watch if we are on the last page
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context).themeData;
    final deviceH = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: [
        //PageView
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              if (index == 2) {
                onLastPage = true;
              }
            });
          },
          children: const [
            IntroPage1(),
            IntroPage2(),
            IntroPage3(),
          ],
        ),

        //
        //DotIndicator
        Padding(
          padding: EdgeInsets.only(bottom: deviceH <= 750 ? 26 : 45),
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Skip Button

                TextButton(
                  onPressed: () {
                    _controller.jumpToPage(2);
                  },
                  child: Text(
                    'Skip',
                    style: GoogleFonts.raleway(
                      color: Colors.green.shade400,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                //Indicators
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: WormEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.green.shade300,
                  ),
                ),

                //Next Button
                onLastPage
                    ? TextButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                          );
                          //
                          // Check if is the first launch
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('firstLaunch', false);
                        },
                        child: Text(
                          'Done',
                          style: GoogleFonts.raleway(
                            color: currentTheme == darkMode
                                ? Colors.white
                                : Colors.grey[800],
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Text(
                          'Next',
                          style: GoogleFonts.raleway(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
