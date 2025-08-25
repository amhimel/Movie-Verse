import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../constants/my_app_colors.dart';
import '../constants/my_app_icons.dart';
import '../screens/favorite_screen.dart';
import '../screens/movie_screen.dart';
import '../screens/tv_series_screen.dart';
import 'custom_appbar.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({super.key});

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  int selectedIndex = 0;

  final List<IconData> icons = [
    LucideIcons.clapperboard, // Movies
    LucideIcons.tv,           // TV Series
    LucideIcons.heart,        // Favorite
  ];

  final List<String> labels = [
    "Movies",
    "TV Series",
    "Favorite",
  ];

  // Add your actual screens here
  final List<Widget> screens = [
    MovieScreen(),
    TvSeriesScreen(),
    FavoriteScreen(),
    // Center(child: Text("Movie Screen", style: TextStyle(color: Colors.white, fontSize: 22))),
    // Center(child: Text("TV Series Screen", style: TextStyle(color: Colors.white, fontSize: 22))),
    // Center(child: Text("Favorite Screen", style: TextStyle(color: Colors.white, fontSize: 22))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: Text("Hey, Himel"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: MyAppColors.searchIconButtonBackColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              icon: Icon(MyAppIcons.search, color: Colors.white),
              onPressed: () {
                // Action for search button
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: MyAppColors.searchIconButtonBackColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              icon: Icon(MyAppIcons.profile, color: Colors.white),
              onPressed: () {
                // Action for search button
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: screens[selectedIndex], // Show selected screen
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1C),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(icons.length, (index) {
              final isSelected = index == selectedIndex;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.red : Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        icons[index],
                        color: isSelected ? Colors.white : Colors.white70,
                        size: 26,
                      ),
                      if (isSelected) ...[
                        const SizedBox(width: 8),
                        Text(
                          labels[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ]
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
