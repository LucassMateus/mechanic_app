import 'package:flutter/material.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';
import 'package:mechanic_app/app/core/ui/alerts/alerts.dart';
import 'package:mechanic_app/app/core/ui/components/custom_drawer.dart';
import 'package:mechanic_app/app/helpers/helpers.dart';
import 'package:mechanic_app/app/core/ui/pages/new_budget_page.dart';
import 'package:mechanic_app/app/modules/home/presenter/controllers/home_controller.dart';
import 'package:mechanic_app/app/modules/service_order/domain/models/service_order.dart';

class HomePage extends StatefulWidget {
  const HomePage({required this.controller, super.key});

  final HomeController controller;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController get controller => widget.controller;

  @override
  void initState() {
    controller.addListener(listener);
    controller.getServiceOrders();
    super.initState();
  }

  void listener() {
    return switch (controller.state) {
      SuccessState() =>
        Alerts.showSuccess(context, 'Ordens carregadas com sucesso'),
      ErrorState(:final exception) =>
        Alerts.showFailure(context, exception.toString()),
      _ => null,
    };
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: colorScheme.primary),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.onPrimary,
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            Card(
              // color: colorScheme.surfaceDim,
              elevation: 3,
              child: Container(
                margin: const EdgeInsetsDirectional.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Próximas Ordens de Serviço',
                      style: TextStyle(color: colorScheme.onSurface),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 360,
                      child: ValueListenableBuilder(
                        valueListenable: controller,
                        builder: (_, state, child) {
                          return switch (state) {
                            SuccessState(:final List<ServiceOrderModel> data) =>
                              ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final orderService = data[index];

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 0,
                                      vertical: 2,
                                    ),
                                    child: OutlinedButton(
                                      style: TextButton.styleFrom(
                                        minimumSize: Size(size.width, 64),
                                        backgroundColor:
                                            colorScheme.onInverseSurface,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Carro ${orderService.car.model}',
                                                style: TextStyle(
                                                    color:
                                                        colorScheme.onSurface),
                                              ),
                                              Text(
                                                'Cliente ${orderService.clientName}',
                                                style: TextStyle(
                                                    color: colorScheme.outline),
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Data: ${Helpers.formatDate(orderService.startedDate)}',
                                                style: TextStyle(
                                                    color:
                                                        colorScheme.onSurface),
                                              ),
                                              Text(
                                                'Horas previstas: 1$index',
                                                style: TextStyle(
                                                    color: colorScheme.outline),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ErrorState(:final Exception exception) => Center(
                                child: Text(exception.toString()),
                              ),
                            _ => const Center(
                                child: CircularProgressIndicator.adaptive(),
                              ),
                          };
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('Ver Mais'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size(size.width, 80),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                // backgroundColor: colorScheme.surfaceDim,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const NewBudgetPage();
                  },
                );
              },
              child: Text(
                'Novo Orçamento',
                style: TextStyle(color: colorScheme.onSurface),
              ),
            )
          ],
        ),
      ),
    );
  }
}
