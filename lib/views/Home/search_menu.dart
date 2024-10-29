import 'package:digital_canteen/utils/constants/colors.dart';
import 'package:digital_canteen/views/Home/favourites/favourite_screen.dart';
import 'package:digital_canteen/views/Home/new_dishes.dart';
import 'package:digital_canteen/widgets/elevated_button.dart';
import 'package:flutter/material.dart';

class MenuContainer extends StatefulWidget {
  final Function(bool highToLow, bool lowToHigh, bool shortTime, bool longTime)
      onApplyFilters;

  const MenuContainer({
    super.key,
    required this.onApplyFilters,
  });

  @override
  State<MenuContainer> createState() => _MenuContainerState();
}

class _MenuContainerState extends State<MenuContainer> {
  bool _highToLow = false;
  bool _lowToHigh = false;
  bool _shortTime = false;
  bool _longTime = false;

  void onSortPressed() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext ctx) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return SizedBox(
              height: 450,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Sort by',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          splashColor: NColors.lightGrey,
                          highlightColor: NColors.lightGrey,
                          onTap: () {
                            Navigator.pop(ctx);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: NColors.lightGrey),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.close_rounded),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        const Divider(
                          color: NColors.lightGrey,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CheckboxListTile(
                          activeColor: NColors.primary,
                          title: const Text(
                            'Cost: High to Low',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          value: _highToLow,
                          onChanged: (value) {
                            setModalState(() {
                              _highToLow = value!;
                              _lowToHigh = false;
                            });
                          },
                        ),
                        CheckboxListTile(
                          activeColor: NColors.primary,
                          title: const Text(
                            'Cost: Low to High',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          value: _lowToHigh,
                          onChanged: (value) {
                            setModalState(() {
                              _lowToHigh = value!;
                              _highToLow = false;
                            });
                          },
                        ),
                        CheckboxListTile(
                          activeColor: NColors.primary,
                          title: const Text(
                            'Cooking Time: Short to Long',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          value: _shortTime,
                          onChanged: (value) {
                            setModalState(() {
                              _shortTime = value!;
                              _longTime = false;
                            });
                          },
                        ),
                        CheckboxListTile(
                          activeColor: NColors.primary,
                          title: const Text(
                            'Cooking Time: Long to Short',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          value: _longTime,
                          onChanged: (value) {
                            setModalState(() {
                              _longTime = value!;
                              _shortTime = false;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  NElevatedButton(
                    text: 'Apply Changes',
                    onPressed: () {
                      setState(() {
                        widget.onApplyFilters(
                            _highToLow, _lowToHigh, _shortTime, _longTime);
                        Navigator.pop(context);
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildMenuItem(Icons.sort, 'Sort', onSortPressed),
        _buildMenuItem(Icons.favorite, 'Favourites', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FavouriteScreen()),
          );
        }),
        _buildMenuItem(Icons.dining_outlined, 'New Dishes', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewDishes()),
          );
        }),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String text, [VoidCallback? onPressed]) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: NColors.lightGrey,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        splashColor: NColors.light,
        borderRadius: BorderRadius.circular(8),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12),
          child: Row(
            children: [
              Icon(
                icon,
                color: NColors.primary,
              ),
              const SizedBox(width: 5),
              Text(
                text,
                style: const TextStyle(color: NColors.darkGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
