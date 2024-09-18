import 'package:flutter/material.dart';

class QuantitySelector extends StatefulWidget {
  final List<dynamic> quantityOptions;
  final double price;

  const QuantitySelector(
      {super.key, required this.quantityOptions, required this.price});

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  String? selectedPriceOption;
  int selectedQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return widget.quantityOptions.isNotEmpty
        ? Column(
            children: widget.quantityOptions.map<Widget>((option) {
              double optionPrice = (option['price'] as num).toDouble();
              return RadioListTile(
                title: Text(
                    '${option['title']} - ₹${optionPrice.toStringAsFixed(2)}'),
                value: optionPrice.toString(),
                groupValue: selectedPriceOption,
                onChanged: (value) {
                  setState(() {
                    selectedPriceOption = value.toString();
                  });
                },
              );
            }).toList(),
          )
        : RadioListTile(
            title: Text('Price - ₹${widget.price.toStringAsFixed(2)}'),
            value: widget.price.toString(),
            groupValue: selectedPriceOption,
            onChanged: (value) {
              setState(() {
                selectedPriceOption = value.toString();
              });
            },
          );
  }
}
