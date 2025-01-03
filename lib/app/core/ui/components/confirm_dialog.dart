import 'package:flutter/material.dart';

class ConfirmDialog {
  final BuildContext context;
  final String title;
  final String message;
  final void Function() onConfirm;
  final void Function()? onCancel;

  ConfirmDialog.show({
    required this.context,
    required this.title,
    required this.message,
    required this.onConfirm,
    this.onCancel,
  }) {
    _showDialog(context);
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _buildDialog(context),
    );
  }

  Widget _buildDialog(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => (onCancel != null) ? onCancel!() : _close(context),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            _close(context);
          },
          child: const Text('Confirmar'),
        ),
      ],
    );
  }

  void _close(BuildContext context) {
    Navigator.pop(context);
  }
}
