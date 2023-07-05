import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceryItemRow extends StatelessWidget {
  const GroceryItemRow({required this.item, super.key});
  final GroceryItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          ColoredBox(
              color: item.category.color,
              child: const SizedBox(width: 30, height: 30)),
          const SizedBox(width: 40),
          Text(
            item.name,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Text(item.quantity.toString()),
        ],
      ),
    );
  }
}
