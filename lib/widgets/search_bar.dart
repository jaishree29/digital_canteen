import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:digital_canteen/widgets/sort_bottom_sheet.dart';
import 'package:flutter/material.dart';

class NSearchBar extends StatelessWidget {
  NSearchBar({super.key});

  final SearchController _searchController = SearchController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: NColors.lightGrey,
          strokeAlign: BorderSide.strokeAlignInside,
          width: 2
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          controller: _searchController,
          decoration:  const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 6.0),
            enabledBorder: InputBorder.none,
            suffixIcon: SortMenu(icon: Icon(Icons.menu_rounded)),
            prefixIcon: Icon(
              Icons.search_rounded,
              size: 30,
            ),
            prefixIconColor: NColors.primary,
            hintText: 'Search',
            hintStyle: TextStyle(
              fontSize: 18
            )
          ),
          cursorColor: NColors.primary,
        ),
      ),
    );
  }
}
