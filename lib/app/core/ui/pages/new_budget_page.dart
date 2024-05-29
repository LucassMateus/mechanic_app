import 'package:flutter/material.dart';
import 'package:mechanic_app/app/core/ui/components/custom_text_field.dart';
import 'package:mechanic_app/app/core/ui/components/full_dialog_widget.dart';

class NewBudgetPage extends StatelessWidget {
  const NewBudgetPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FullDialogWidget(
      title: 'Novo Orçamento',
      onConfirmText: 'Salvar',
      onCancelText: 'Cancelar',
      onConfirmPressed: () {},
      onCancelPressed: () {
        Navigator.of(context).pop();
      },
      builder: (context) {
        return const Column(
          children: [
            CustomTextFormField(label: 'Cliente'),
            CustomTextFormField(label: 'Carro'),
            CustomTextFormField(label: 'Placa'),
            CustomTextFormField(label: 'Data'),
            CustomTextFormField(label: 'Serviços'),
            CustomTextFormField(label: 'Itens Adicionais'),
            CustomTextFormField(label: 'Horas Adicionais'),
            CustomTextFormField(label: 'Observações'),
            CustomTextFormField(label: 'Status'),
          ],
        );
      },
    );
  }
}
