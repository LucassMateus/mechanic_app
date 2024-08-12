import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class CustomSearchField<T> extends StatefulWidget {
  const CustomSearchField({
    super.key,
    required this.data,
    required this.label,
    this.radius = 16,
    this.itemAsString,
    this.onChanged,
    this.emptyLabel,
  });
  final List<T> data;
  final String label;
  final double radius;
  final String Function(T)? itemAsString;
  final void Function(T?)? onChanged;
  final String? emptyLabel;

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState<T>();
}

class _CustomSearchFieldState<T> extends State<CustomSearchField<T>> {
  List<T> get data => widget.data;
  double get radius => widget.radius;
  String get label => widget.label;
  String Function(T)? get itemAsString => widget.itemAsString;
  void Function(T?)? get onChanged => widget.onChanged;
  String get emptyLabel => widget.emptyLabel ?? 'Nenhum item encontrado';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: DropdownSearch<T>(
        items: data,
        itemAsString: itemAsString,
        onChanged: onChanged,
        popupProps: PopupProps.menu(
          constraints: const BoxConstraints(maxHeight: 300),
          // showSelectedItems: true,
          showSearchBox: true,
          searchDelay: const Duration(milliseconds: 300),
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              labelText: 'Digite para pesquisar...',
              border: OutlineInputBorder(
                borderSide: const BorderSide(),
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
            cursorHeight: 20,
          ),
          emptyBuilder: (context, searchEntry) {
            return Center(
              child: Text(emptyLabel),
            );
          },
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(fontSize: 15),
            border: OutlineInputBorder(
              borderSide: const BorderSide(),
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        ),
      ),
    );
  }
}
