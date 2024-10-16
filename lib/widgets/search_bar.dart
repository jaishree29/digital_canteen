import 'dart:async';
import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:digital_canteen/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';

class NSearchBar extends StatefulWidget {
  NSearchBar({super.key});

  @override
  _NSearchBarState createState() => _NSearchBarState();
}

class _NSearchBarState extends State<NSearchBar> {
  final SearchController _searchController = SearchController();
  List<String> hintTexts = ['Search "Chili Paneer" ', 'Search "Gravy Momos" ', 'Search "Noodles" '];
  int currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Set a timer to cycle through the hint texts
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % hintTexts.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: NColors.lightGrey,
            strokeAlign: BorderSide.strokeAlignInside,
            width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          textAlign: TextAlign.center,
          controller: _searchController,
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 6.0),
              enabledBorder: InputBorder.none,
              suffixIcon: const NBottomSheet(
                icon: Icon(
                  Icons.menu_rounded,
                  size: 30,
                ),
                widget: Column(
                  children: [],
                ),
                text: 'Sort by',
              ),
              prefixIcon: const Icon(
                Icons.search_rounded,
                size: 30,
              ),
              prefixIconColor: NColors.primary,
              hintText: hintTexts[currentIndex], // Slideshow hint text
              hintStyle: const TextStyle(fontSize: 18)),
          cursorColor: NColors.primary,
        ),
      ),
    );
  }
}
