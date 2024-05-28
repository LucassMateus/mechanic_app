import 'package:flutter/material.dart';

class RegistrationCardWidget extends StatelessWidget {
  const RegistrationCardWidget({
    required this.title,
    required this.subTitle,
    this.onEdit,
    this.onRemove,
    this.color,
    super.key,
  });

  final String title;
  final String subTitle;
  final Color? color;
  final void Function()? onEdit;
  final void Function()? onRemove;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                title: Text(title),
                subtitle: Text(subTitle),
              ),
            ),
            IconButton(
              onPressed: onEdit,
              icon: const Icon(
                Icons.edit_outlined,
              ),
            ),
            IconButton(
              onPressed: onRemove,
              icon: Icon(
                Icons.delete_outline_outlined,
                color: colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
