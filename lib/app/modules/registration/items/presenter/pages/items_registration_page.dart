import 'package:flutter/material.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';
import 'package:mechanic_app/app/core/ui/components/custom_drawer.dart';
import 'package:mechanic_app/app/core/ui/components/custom_search_widget.dart';
import 'package:mechanic_app/app/core/ui/components/registration_card_widget.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';
import 'package:mechanic_app/app/modules/registration/items/presenter/controllers/items_registration_controller.dart';
import 'package:mechanic_app/app/modules/service_order/domain/models/service_order.dart';

class ItemsRegistrationPage extends StatefulWidget {
  ItemsRegistrationPage({super.key});
  final ItemsRegistrationController controller = ItemsRegistrationController();

  @override
  State<ItemsRegistrationPage> createState() => _ItemsRegistrationPageState();
}

class _ItemsRegistrationPageState extends State<ItemsRegistrationPage> {
  ItemsRegistrationController get controller => widget.controller;

  @override
  void initState() {
    controller.setItems();
    super.initState();
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
            onPressed: () {},
            icon: const Icon(
              Icons.add_outlined,
              size: 32,
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
                onChanged: controller.filterItems),
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
                            // onRemove: controller.remove(item),
                          );
                        },
                      ),
                    _ => const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                  };
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
