import 'package:flutter/material.dart';

class FullDialogWidget extends StatefulWidget {
  const FullDialogWidget({
    super.key,
    required this.title,
    required this.onConfirmText,
    required this.onCancelText,
    this.onConfirmPressed,
    this.onCancelPressed,
    this.onDispose,
    required this.builder,
  });

  final String title;
  final String onConfirmText;
  final String onCancelText;
  final void Function()? onConfirmPressed;
  final void Function()? onCancelPressed;
  final void Function()? onDispose;
  final Widget Function(BuildContext context) builder;

  @override
  State<FullDialogWidget> createState() => _FullDialogWidgetState();
}

class _FullDialogWidgetState extends State<FullDialogWidget> {
  @override
  void dispose() {
    widget.onDispose;
    super.dispose();
  }

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
                  widget.title,
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
            Expanded(
              child: SingleChildScrollView(
                child: widget.builder(context),
              ),
            ),
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
                  onPressed: widget.onConfirmPressed,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      widget.onConfirmText,
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
                  onPressed: widget.onCancelPressed ??
                      () => Navigator.of(context).pop(),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      widget.onCancelText,
                      style: TextStyle(color: colorScheme.primary),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
