import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mechanic_app/app/core/state/base_state.dart';
import 'package:mechanic_app/app/core/ui/alerts/alerts.dart';
import 'package:mechanic_app/app/core/ui/components/custom_drawer.dart';
import 'package:mechanic_app/app/core/ui/components/custom_search_widget.dart';
import 'package:mechanic_app/app/core/ui/components/custom_text_field.dart';
import 'package:mechanic_app/app/core/ui/components/full_dialog_widget.dart';
import 'package:mechanic_app/app/core/ui/components/registration_card_widget.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';
import 'package:mechanic_app/app/modules/registration/items/presenter/controllers/items_registration_controller.dart';

import '../../domain/dtos/item_save_dto.dart';

class ItemsRegistrationPage extends StatefulWidget {
  const ItemsRegistrationPage({
    super.key,
    required this.controller,
  });

  final ItemsRegistrationController controller;

  @override
  State<ItemsRegistrationPage> createState() => _ItemsRegistrationPageState();
}

class _ItemsRegistrationPageState extends State<ItemsRegistrationPage> {
  ItemsRegistrationController get controller => widget.controller;
  final itemSaveDto = ItemSaveDto();

  @override
  void initState() {
    controller.addListener(listener);
    controller.getItems();
    super.initState();
  }

  void listener() {
    return switch (controller.state) {
      SuccessState() =>
        Alerts.showSuccess(context, 'Itens buscados com sucesso!'),
      ErrorState(:final exception) =>
        Alerts.showFailure(context, exception.toString()),
      _ => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Itens'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    final codeEC = TextEditingController();
                    final descriptionEC = TextEditingController();
                    final costEC = TextEditingController();

                    return FullDialogWidget(
                      title: 'Novo Item',
                      onConfirmText: 'Salvar',
                      onCancelText: 'Cancelar',
                      onConfirmPressed: () async {
                        final navigator = Navigator.of(context);
                        await controller.saveItem(itemSaveDto);
                        if (mounted) navigator.pop();
                      },
                      onCancelPressed: () => Navigator.pop(context),
                      builder: (context) {
                        return Column(
                          children: [
                            CustomTextFormField(
                              label: 'Codigo',
                              controller: codeEC,
                              onChanged: itemSaveDto.setCode,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                            CustomTextFormField(
                              label: 'Descrição',
                              controller: descriptionEC,
                              onChanged: itemSaveDto.setDescription,
                            ),
                            CustomTextFormField(
                              label: 'Custo',
                              controller: costEC,
                              onChanged: (value) => itemSaveDto.setCost(
                                UtilBrasilFields.removerSimboloMoeda(
                                  value ?? '',
                                ),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CentavosInputFormatter(
                                  casasDecimais: 2,
                                  moeda: true,
                                )
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  });
            },
            icon: const Icon(
              Icons.add_outlined,
              size: 28,
            ),
          )
        ],
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            CustomSearchWidget(
              label: 'Digite para pesquisar...',
              color: colorScheme.outlineVariant,
              onChanged: controller.filterItems,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: controller,
                builder: (_, state, child) {
                  return switch (state) {
                    SuccessState(:final List<ItemModel> data) =>
                      ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final item = data[index];
                          return RegistrationCardWidget(
                            title: item.code.toString(),
                            subTitle: item.description,
                            color: colorScheme.outlineVariant,
                            onRemove: () => controller.removeItem(item),
                            onEdit: () => showDialog(
                              context: context,
                              builder: (context) {
                                final codeEC = TextEditingController(
                                    text: item.code.toString());
                                final descriptionEC = TextEditingController(
                                    text: item.description);
                                final costEC = TextEditingController(
                                  text: UtilBrasilFields.obterReal(item.cost),
                                );

                                return FullDialogWidget(
                                  title: 'Item: ${item.code}',
                                  onConfirmText: 'Atualizar',
                                  onCancelText: 'Cancelar',
                                  onConfirmPressed: () async {
                                    final costReplaced =
                                        UtilBrasilFields.removerSimboloMoeda(
                                      costEC.text,
                                    ).replaceAll(',', '.');

                                    final updatedItem = ItemModel(
                                      id: item.id,
                                      code: int.tryParse(codeEC.text) ?? 0,
                                      description: descriptionEC.text,
                                      cost: double.tryParse(costReplaced) ?? 0,
                                    );
                                    final navigator = Navigator.of(context);
                                    await controller.updateItem(updatedItem);
                                    if (mounted) navigator.pop();
                                  },
                                  onCancelPressed: () =>
                                      Navigator.of(context).pop(),
                                  builder: (context) {
                                    return Column(
                                      children: [
                                        CustomTextFormField(
                                          label: 'Codigo',
                                          controller: codeEC,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                        ),
                                        CustomTextFormField(
                                          label: 'Descrição',
                                          controller: descriptionEC,
                                        ),
                                        CustomTextFormField(
                                          label: 'Custo',
                                          controller: costEC,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            CentavosInputFormatter(
                                              casasDecimais: 2,
                                              moeda: true,
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                    _ => const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
