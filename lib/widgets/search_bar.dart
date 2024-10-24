import 'dart:async';
import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class NSearchBar extends StatefulWidget {
  final VoidCallback onMenuPressed;
  final ValueChanged<String> onSearchChanged;

  const NSearchBar({
    super.key,
    required this.onMenuPressed,
    required this.onSearchChanged,
  });

  @override
  State<NSearchBar> createState() => _NSearchBarState();
}

class _NSearchBarState extends State<NSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  List<String> hintTexts = [
    'Chili Paneer',
    'Gravy Momos',
    'Noodles',
  ];
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

    // Listen to changes in the search field
    _searchController.addListener(() {
      widget.onSearchChanged(_searchController.text);
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); 
    _searchController.dispose();
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
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 5.0),
        child: TextField(
          textAlign: TextAlign.start,
          controller: _searchController,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 6.0),
            enabledBorder: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.menu_rounded,
                size: 30,
              ),
              onPressed: widget.onMenuPressed,
            ),
            prefixIcon: const Icon(
              Icons.search_rounded,
              size: 30,
            ),
            prefixIconColor: NColors.primary,
            hintText:
                'Search "${hintTexts[currentIndex]}"', // Slideshow hint text
            hintStyle: const TextStyle(fontSize: 18),
          ),
          cursorColor: NColors.primary,
        ),
      ),
    );
  }
}
