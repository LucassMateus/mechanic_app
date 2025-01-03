import 'package:flutter/material.dart';
import 'package:mechanic_app/app/core/styles/app_styles.dart';
import 'package:mechanic_app/app/core/styles/colors_app.dart';

class RegistrationWidget extends StatefulWidget {
  final Widget Function(BuildContext context) builder;
  final VoidCallback? onSaved;
  final VoidCallback? onCancel;

  const RegistrationWidget(
      {super.key, required this.builder, this.onSaved, this.onCancel});

  @override
  State<RegistrationWidget> createState() => _RegistrationWidgetState();
}

class _RegistrationWidgetState extends State<RegistrationWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 15,
            child: widget.builder(context),
          ),
          const Divider(),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                TextButton(
                  style: context.appStyles.primaryTextButton,
                  onPressed: widget.onSaved,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      'Salvar',
                      style: TextStyle(color: context.colors.secondary),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  style: context.appStyles.secondaryButton,
                  onPressed:
                      widget.onCancel ?? () => Navigator.of(context).pop(),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      'Cancelar',
                      style: TextStyle(color: context.colors.primary),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
