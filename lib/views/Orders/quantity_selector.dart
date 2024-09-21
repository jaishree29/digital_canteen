import 'package:flutter/material.dart';

class QuantitySelector extends StatefulWidget {
  final Map<String, dynamic>
      priceData; // Map containing 'half' and 'full' as keys

  const QuantitySelector({
    super.key,
    required this.priceData,
  });

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  String? selectedPriceOption;
  int selectedQuantity = 0;
  double selectedPrice = 0;

  void _handleSelection(String? value) {
    setState(() {
      if (selectedPriceOption == value) {
        // Deselecting the already selected value
        selectedPriceOption = null;
        selectedPrice = 0;
        selectedQuantity = 0;
      } else {
        selectedPriceOption = value;
        selectedPrice = double.parse(value!);
        selectedQuantity = 1;
      }
      // Notify parent or update the state for the total price (in bottom bar or other components)
    });
  }

  @override
  Widget build(BuildContext context) {
    bool hasHalf = widget.priceData.containsKey('half');
    bool hasFull = widget.priceData.containsKey('full');

    return Column(
      children: [
        if (hasHalf)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(child: Text('Half')),
              Radio<String>(
                value: widget.priceData['half'].toString(),
                groupValue: selectedPriceOption,
                onChanged: _handleSelection,
              ),
            ],
          ),

        if (hasFull)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(child: Text('Full')),
              Radio<String>(
                value: widget.priceData['full'].toString(),
                groupValue: selectedPriceOption,
                onChanged: _handleSelection,
              ),
            ],
          ),
      ],
    );
  }
}
