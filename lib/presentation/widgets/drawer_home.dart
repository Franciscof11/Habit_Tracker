import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/presentation/widgets/theme_mode_widget.dart';
import 'package:habit_tracker/utils/theme/dark_mode.dart';
import 'package:habit_tracker/utils/theme/light_mode.dart';
import 'package:provider/provider.dart';

import '../../utils/theme/theme_provider.dart';

class DrawerHome extends StatefulWidget {
  const DrawerHome({super.key});

  @override
  State<DrawerHome> createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context).themeData;
    return Drawer(
      child: Column(
        children: [
          const SizedBox(height: 60),
          //
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
          //
          const SizedBox(height: 40),
          Column(
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
                  color: isSelected ? Colors.grey[600] : Colors.green.shade400,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),
          Column(
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
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
