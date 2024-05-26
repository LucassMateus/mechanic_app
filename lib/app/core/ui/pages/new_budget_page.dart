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
            CustomTextField(label: 'Cliente'),
            CustomTextField(label: 'Carro'),
            CustomTextField(label: 'Placa'),
            CustomTextField(label: 'Data'),
            CustomTextField(label: 'Serviços'),
            CustomTextField(label: 'Itens Adicionais'),
            CustomTextField(label: 'Horas Adicionais'),
            CustomTextField(label: 'Observações'),
            CustomTextField(label: 'Status'),
          ],
        );
      },
    );
  }
}
