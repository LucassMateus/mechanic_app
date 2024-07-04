import 'package:flutter/material.dart';
import 'package:mechanic_app/app/core/ui/components/custom_text_field.dart';
import 'package:mechanic_app/app/core/ui/components/full_dialog_widget.dart';

class BudgetDialog extends StatelessWidget {
  const BudgetDialog({
    super.key,
    required this.title,
    required this.onConfirmText,
    required this.onCancelText,
    this.onConfirmPressed,
    this.onCancelPressed,
    this.showStatus = false,
  });

  final String title;
  final String onConfirmText;
  final String onCancelText;
  final void Function()? onConfirmPressed;
  final void Function()? onCancelPressed;
  final bool showStatus;

  @override
  Widget build(BuildContext context) {
    return FullDialogWidget(
      title: title,
      onConfirmText: onConfirmText,
      onCancelText: onCancelText,
      onConfirmPressed: onConfirmPressed,
      onCancelPressed: onCancelPressed ?? () => Navigator.of(context).pop(),
      builder: (context) {
        return Column(
          children: [
            const CustomTextFormField(label: 'Cliente'),
            const CustomTextFormField(label: 'Carro'),
            const CustomTextFormField(label: 'Placa'),
            const CustomTextFormField(label: 'Data'),
            const CustomTextFormField(label: 'Serviços'),
            const CustomTextFormField(label: 'Itens Adicionais'),
            const CustomTextFormField(label: 'Horas Adicionais'),
            const CustomTextFormField(label: 'Observações'),
            Visibility(
              visible: showStatus,
              child: const CustomTextFormField(label: 'Status'),
            )
            // CustomTextFormField(label: 'Status'),
          ],
        );
      },
    );
  }
}
