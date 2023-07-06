import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItem = [];

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
    if (newItem != null) {
      setState(() {
        _groceryItem.add(newItem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget groceryListContent;

    if (_groceryItem.isEmpty) {
      groceryListContent = Center(
        child: Text(
          'No Groceries Yet! Please add some!',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary, fontSize: 20),
        ),
      );
    } else {
      groceryListContent = ListView.builder(
        itemCount: _groceryItem.length,
        itemBuilder: (context, index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            background: Container(
              color: Theme.of(context).colorScheme.error,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              child: const Icon(
                Icons.delete,
                color: Colors.red,
                size: 40,
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                _groceryItem.removeAt(index);
              });
            },
            key: ValueKey(_groceryItem[index].id),
            child: ListTile(
              title: Text(_groceryItem[index].name),
              leading: Container(
                width: 24,
                height: 24,
                color: _groceryItem[index].category.color,
              ),
              trailing: Text(_groceryItem[index].quantity.toString()),
            ),
          );
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [IconButton(onPressed: _addItem, icon: const Icon(Icons.add))],
      ),
      body: groceryListContent,
    );
  }
}
