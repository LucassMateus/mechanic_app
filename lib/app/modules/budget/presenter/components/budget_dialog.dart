import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mechanic_app/app/core/models/document_service.dart';
import 'package:mechanic_app/app/core/ui/alerts/alerts.dart';
import 'package:mechanic_app/app/core/ui/base_state_page.dart/base_state_page.dart';
import 'package:mechanic_app/app/core/ui/components/custom_search_field.dart';
import 'package:mechanic_app/app/core/ui/components/custom_text_field.dart';
import 'package:mechanic_app/app/core/ui/components/full_dialog_widget.dart';
import 'package:mechanic_app/app/modules/budget/domain/dtos/budget_save_dto.dart';
import 'package:mechanic_app/app/modules/budget/presenter/controllers/budget_dialog_controller.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/models/service_model.dart';

import '../../../../core/state/base_state.dart';
import '../../../registration/cars/domain/models/car_model.dart';
import '../../../registration/customers/domain/models/customer_model.dart';

class BudgetDialog extends StatefulWidget {
  const BudgetDialog({
    super.key,
    required this.controller,
    required this.title,
    required this.onConfirmText,
    required this.onCancelText,
    this.onConfirmPressed,
    this.onCancelPressed,
    this.showStatus = false,
  });

  final BudgetDialogController controller;
  final String title;
  final String onConfirmText;
  final String onCancelText;
  final void Function()? onConfirmPressed;
  final void Function()? onCancelPressed;
  final bool showStatus;

  @override
  State<BudgetDialog> createState() => _BudgetDialogState();
}

class _BudgetDialogState
    extends BaseStatePage<BudgetDialog, BudgetDialogController> {
  String get title => widget.title;
  String get onConfirmText => widget.onConfirmText;
  String get onCancelText => widget.onCancelText;
  void Function()? get onConfirmPressed => widget.onConfirmPressed;
  void Function()? get onCancelPressed => widget.onCancelPressed;
  bool get showStatus => widget.showStatus;

  @override
  void onReady() {
    widget.controller.addListener(listener);
    widget.controller.fetchData();
  }

  @override
  void listener() {
    return switch (controller.state) {
      ErrorState() => Alerts.showFailure(context, 'Erro ao carregar os dados'),
      _ => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    return FullDialogWidget(
      title: title,
      onConfirmText: onConfirmText,
      onCancelText: onCancelText,
      onConfirmPressed: onConfirmPressed,
      onCancelPressed: onCancelPressed ?? () => Navigator.of(context).pop(),
      builder: (context) {
        return ValueListenableBuilder(
            valueListenable: controller,
            builder: (_, state, child) {
              return switch (state) {
                SuccessState<BudgetSaveDto>() => Expanded(
                    child: Column(
                      children: [
                        CustomSearchField<CustomerModel>(
                          data: controller.customers,
                          label: 'Cliente',
                          itemAsString: (customer) => customer.name,
                          onChanged: controller.setCustomer,
                          emptyLabel: 'Nenhum cliente encontrado',
                        ),
                        CustomSearchField<CarModel>(
                          data: controller.budgetSaveDto.customerCars,
                          label: 'Carro',
                          itemAsString: (car) => car.model,
                          onChanged: controller.setCar,
                          emptyLabel: 'Nenhum carro encontrado',
                        ),
                        // CustomTextFormField(
                        //   label: 'Placa',
                        //   inputFormatters: [
                        //     FilteringTextInputFormatter.digitsOnly,
                        //     PlacaVeiculoInputFormatter(),
                        //   ],
                        // ),
                        CustomTextFormField(
                          label: 'Data',
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            DataInputFormatter(),
                          ],
                        ),
                        CustomSearchField<ServiceModel>(
                          data: controller.services,
                          itemAsString: (service) => service.name,
                          label: 'Serviços',
                          onChanged: (service) =>
                              controller.setServices([service!]),
                        ),
                        CustomSearchField<ItemModel>(
                          data: controller.items,
                          itemAsString: (item) => item.code.toString(),
                          label: 'Itens Adicionais',
                          onChanged: (item) =>
                              controller.setAdditionalItems([item!]),
                        ),
                        CustomTextFormField(
                          label: 'Horas Adicionais',
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: controller.setAdditionalHours,
                        ),
                        CustomTextFormField(
                          label: 'Observações',
                          onChanged: controller.setObservations,
                        ),
                        Visibility(
                          visible: widget.showStatus,
                          child: CustomSearchField<DocumentStatus>(
                            data: controller.documentStatus,
                            itemAsString: (doc) => doc.name,
                            label: 'Status',
                            onChanged: controller.setStatus,
                          ),
                        )
                      ],
                    ),
                  ),
                _ => ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height - 200),
                    child: const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  )
              };
            });
      },
    );
  }
}
