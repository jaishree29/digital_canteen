import 'package:flutter/material.dart';

class SortMenu extends StatelessWidget {
  const SortMenu({super.key, required this.icon});
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext ctx) {
              return SizedBox(
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Sort By', style: TextStyle(fontSize: 25)),
                          InkWell(
                            onTap: (){
                              Navigator.pop(ctx);
                            }, 
                            child: const Icon(Icons.close_rounded),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: icon);
  }
}
