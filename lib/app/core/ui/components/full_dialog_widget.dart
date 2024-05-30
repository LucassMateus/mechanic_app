import 'package:flutter/material.dart';

class FullDialogWidget extends StatelessWidget {
  const FullDialogWidget({
    super.key,
    required this.title,
    required this.onConfirmText,
    required this.onCancelText,
    this.onConfirmPressed,
    this.onCancelPressed,
    required this.builder,
  });

  final String title;
  final String onConfirmText;
  final String onCancelText;
  final void Function()? onConfirmPressed;
  final void Function()? onCancelPressed;
  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Dialog.fullscreen(
      backgroundColor: colorScheme.onSecondary,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 20),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.close,
                    size: 28,
                    color: colorScheme.error,
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            builder(context),
            const Spacer(),
            const Divider(),
            Row(
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    backgroundColor: colorScheme.primary,
                  ),
                  onPressed: onConfirmPressed,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      onConfirmText,
                      style: TextStyle(color: colorScheme.onPrimary),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  style: TextButton.styleFrom(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                        side: BorderSide(color: colorScheme.primary)),
                    backgroundColor: colorScheme.onPrimary,
                  ),
                  onPressed:
                      onCancelPressed ?? () => Navigator.of(context).pop(),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      onCancelText,
                      style: TextStyle(color: colorScheme.primary),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
