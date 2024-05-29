import 'package:flutter/material.dart';

class CustomSearchWidget extends StatelessWidget {
  const CustomSearchWidget({
    required this.label,
    this.color,
    this.actions = const [],
    this.onChanged,
    super.key,
  });

  final String label;
  final Color? color;
  final List<PopupMenuEntry<Object?>> actions;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: label,
                border: InputBorder.none,
              ),
              onChanged: onChanged,
            ),
          ),
          const Icon(Icons.search_outlined),
          Visibility(
            visible: actions.isNotEmpty,
            child: PopupMenuButton(
              itemBuilder: (context) => [],
            ),
          )
        ],
      ),
    );
  }
}
