import 'package:flutter/material.dart';
import 'package:mechanic_app/app/core/ui/components/custom_search_widget.dart';

import '../../theme/theme_config.dart';

class MultiSelectDialog<T> extends StatefulWidget {
  final String title;
  final Iterable<T> items;
  final Iterable<T>? selectedItems;
  final String Function(T) itemTextBuilder;
  final void Function(T item, bool isSelected)? onItemChange;
  final Iterable<T> Function(String)? onSearchChanged;

  const MultiSelectDialog({
    super.key,
    required this.title,
    required this.items,
    this.selectedItems,
    required this.itemTextBuilder,
    this.onItemChange,
    this.onSearchChanged,
  });

  @override
  State<MultiSelectDialog<T>> createState() => _MultiSelectDialogState<T>();
}

class _MultiSelectDialogState<T> extends State<MultiSelectDialog<T>> {
  late final List<T> selectedItems;
  late final List<T> filteredItems;

  @override
  void initState() {
    super.initState();
    selectedItems = List<T>.from(widget.selectedItems ?? []);
    filteredItems = List<T>.from(widget.items);
  }

  void _itemChange(T itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedItems.add(itemValue);
      } else {
        selectedItems.remove(itemValue);
      }
    });

    widget.onItemChange?.call(itemValue, isSelected);
  }

  void _itemSearch(String search) {
    setState(() {
      filteredItems.clear();
      filteredItems.addAll(widget.onSearchChanged?.call(search) ?? []);
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() {
    Navigator.pop(context, selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          title: Text(widget.title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomSearchWidget(
                label: 'Digite para pesquisar',
                color: ThemeConfig.theme.colorScheme.secondary,
                onChanged: _itemSearch,
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                child: ListBody(
                  children: filteredItems
                      .map((item) => CheckboxListTile(
                            value: selectedItems.contains(item),
                            title: Text(widget.itemTextBuilder(item)),
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (isChecked) =>
                                _itemChange(item, isChecked ?? false),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: _cancel,
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }
}
