import 'package:flutter/material.dart';
import 'package:mechanic_app/app/helpers/debouncer.dart';

class CustomSearchWidget extends StatelessWidget {
  const CustomSearchWidget({
    required this.label,
    this.size,
    this.color,
    this.onChanged,
    this.debounceTime = const Duration(milliseconds: 500),
    this.actions = const [],
    this.onSelectedAction,
    super.key,
  });

  final String label;
  final Color? color;
  final Size? size;
  final void Function(String)? onChanged;
  final Duration debounceTime;
  final List<PopupMenuEntry<String?>> actions;
  final void Function(String?)? onSelectedAction;

  @override
  Widget build(BuildContext context) {
    final Debouncer debouncer = Debouncer(duration: debounceTime);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: size?.height,
      width: size?.width,
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
              onChanged: (value) {
                if (onChanged != null) {
                  debouncer.run(() => onChanged!.call(value));
                }
              },
            ),
          ),
          const Icon(Icons.search_outlined),
          Visibility(
            visible: actions.isNotEmpty,
            child: PopupMenuButton(
              onSelected: onSelectedAction,
              itemBuilder: (context) => actions,
            ),
          ),
        ],
      ),
    );
  }
}
