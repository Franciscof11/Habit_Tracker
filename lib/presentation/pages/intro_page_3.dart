import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/presentation/widgets/theme_mode_widget.dart';
import 'package:habit_tracker/utils/theme/dark_mode.dart';
import 'package:habit_tracker/utils/theme/light_mode.dart';
import 'package:habit_tracker/utils/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class IntroPage3 extends StatefulWidget {
  const IntroPage3({super.key});

  @override
  State<IntroPage3> createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final deviceH = MediaQuery.of(context).size.height;
    final currentTheme = Provider.of<ThemeProvider>(context).themeData;
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
              'assets/intro_3.svg',
              height: deviceH <= 750 ? 300 : 350,
            ),
            SizedBox(
              height: deviceH <= 750 ? 10 : 30,
            ),
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'Choose your ',
                  style: GoogleFonts.raleway(
                    color: currentTheme == darkMode
                        ? Colors.white
                        : Colors.grey[800],
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: 'theme:',
                      style: GoogleFonts.raleway(
                        color: Colors.green.shade400,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: deviceH <= 750 ? 28 : 35),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected = false;
                          });
                          Provider.of<ThemeProvider>(context, listen: false)
                              .changeTheme(darkMode);
                        },
                        child: ThemeModeWidget(
                          iconTheme: MyIconTheme.moon,
                          isSelected: isSelected,
                          label: 'Light ',
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Dark Mode',
                        style: GoogleFonts.raleway(
                          color: isSelected
                              ? Colors.grey[600]
                              : Colors.green.shade400,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 35,
                ),
                Expanded(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected = true;
                          });
                          Provider.of<ThemeProvider>(context, listen: false)
                              .changeTheme(lightMode);
                        },
                        child: ThemeModeWidget(
                          iconTheme: MyIconTheme.sun,
                          isSelected: !isSelected,
                          label: 'Dark',
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Light Mode',
                        style: GoogleFonts.raleway(
                          color: isSelected == false
                              ? Colors.grey[600]
                              : Colors.green.shade400,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
