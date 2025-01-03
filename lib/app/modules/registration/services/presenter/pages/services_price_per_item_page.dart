import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';
import 'package:mechanic_app/app/core/ui/alerts/alerts.dart';
import 'package:mechanic_app/app/core/ui/base_state_page.dart/base_state_page.dart';
import 'package:mechanic_app/app/core/ui/components/custom_search_widget.dart';
import 'package:mechanic_app/app/core/ui/components/error_widget.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';
import 'package:mechanic_app/app/modules/registration/services/presenter/controllers/service_price_per_item_controller.dart';

import '../../../../../core/theme/theme_config.dart';
import '../../../../../core/ui/components/multi_select_dialog.dart';
import '../controllers/services_price_per_car_controller.dart';

class ServicesPricePerItemPage extends StatefulWidget {
  final Set<ItemModel> items;
  const ServicesPricePerItemPage({super.key, required this.items});

  @override
  State<ServicesPricePerItemPage> createState() =>
      _ServicesPricePerItemPageState();
}

class _ServicesPricePerItemPageState extends BaseStatePage<
    ServicesPricePerItemPage, ServicePricePerItemController> {
  @override
  Future<void> onReady() async {
    await controller.init(widget.items);
  }

  @override
  void listener() {
    return switch (controller.state) {
      RemovedCarDetailsState(:final carDetails) => Alerts.showSuccess(
          context,
          '${carDetails.car.fullNameWithYear} excluído',
        ),
      _ => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Itens'),
        actions: [
          IconButton(
            onPressed: () {
              Modular.to.pop(controller.serviceItems);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCarsDialog,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomSearchWidget(
              label: 'Pesquisar itens...',
              color: ThemeConfig.theme.colorScheme.surfaceContainer,
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder(
                valueListenable: controller,
                builder: (_, state, child) {
                  return switch (state) {
                    SuccessState() => Expanded(
                        child: ListView.builder(
                          itemCount: controller.serviceItems.length,
                          itemBuilder: (context, index) {
                            final item =
                                controller.serviceItems.elementAt(index);

                            return Dismissible(
                              key: ValueKey(item),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              onDismissed: (direction) =>
                                  controller.removeItem(item),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: ThemeConfig.theme.colorScheme
                                              .primaryContainer,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Icon(
                                          Icons.settings_outlined,
                                          color: ThemeConfig
                                              .theme.colorScheme.primary,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          '${item.code} ${item.description}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ErrorState(:final exception, :final message) =>
                      CustomErrorWidget(message, exception),
                    _ => const Center(child: CircularProgressIndicator()),
                  };
                })
          ],
        ),
      ),
    );
  }

  void _showCarsDialog() async {
    final Set<ItemModel> items = controller.items;

    final Iterable<ItemModel>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog<ItemModel>(
          title: 'Selecione os itens',
          items: items,
          selectedItems: controller.serviceItems,
          itemTextBuilder: (item) {
            return '${item.code} | ${item.description} | ${item.cost}';
          },
          // onItemChange: (item, isSelected) {},
          // onSearchChanged: controller.filterCars,
        );
      },
    );

    if (results != null) {
      setState(() {
        for (var item in results) {
          final addedItems = controller.serviceItems;

          if (!addedItems.contains(item)) {
            controller.serviceItems.add(item);
          }
        }
      });
    }
  }
}
