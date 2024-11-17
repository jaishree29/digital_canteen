import 'package:flutter/material.dart';

class QuantitySelector extends StatefulWidget {
  final Map<String, dynamic> priceData;
  final Function(double selectedPrice, int selectedQuantity) onSelectionChanged;

  const QuantitySelector({
    super.key,
    required this.priceData,
    required this.onSelectionChanged,
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
        selectedPriceOption = null;
        selectedPrice = 0;
        selectedQuantity = 0;
      } else {
        selectedPriceOption = value;
        selectedPrice = double.parse(value!);
        selectedQuantity = 1;
      }
      widget.onSelectionChanged(selectedPrice, selectedQuantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool hasHalf = widget.priceData.containsKey('half');
    bool hasFull = widget.priceData.containsKey('full');

    double? halfPrice = widget.priceData['half'] != null
        ? (widget.priceData['half'] as num).toDouble()
        : null;
    double? fullPrice = widget.priceData['full'] != null
        ? (widget.priceData['full'] as num).toDouble()
        : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          if (hasHalf)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text('Half - ₹${halfPrice?.toStringAsFixed(2)}'),
                    ),
                    Radio<String>(
                      value: widget.priceData['half'].toString(),
                      groupValue: selectedPriceOption,
                      onChanged: _handleSelection,
                    ),
                  ],
                ),
                const Divider(),
              ],
            ),
          if (hasFull)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text('Full - ₹${fullPrice?.toStringAsFixed(2)}'),
                ),
                Radio<String>(
                  value: widget.priceData['full'].toString(),
                  groupValue: selectedPriceOption,
                  onChanged: _handleSelection,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
