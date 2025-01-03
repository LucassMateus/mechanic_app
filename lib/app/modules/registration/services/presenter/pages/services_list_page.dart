import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';
import 'package:mechanic_app/app/core/ui/alerts/alerts.dart';
import 'package:mechanic_app/app/core/ui/base_state_page.dart/base_state_page.dart';
import 'package:mechanic_app/app/core/ui/components/custom_drawer.dart';
import 'package:mechanic_app/app/core/ui/components/custom_search_widget.dart';
import 'package:mechanic_app/app/core/ui/components/registration_card_widget.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/models/service_model.dart';
import 'package:mechanic_app/app/modules/registration/services/presenter/controllers/services_list_controller.dart';

class ServicesListPage extends StatefulWidget {
  const ServicesListPage({super.key});

  @override
  State<ServicesListPage> createState() => _ServicesListPageState();
}

class _ServicesListPageState
    extends BaseStatePage<ServicesListPage, ServicesListController> {
  @override
  void onReady() async {
    controller.getAllServices();
  }

  @override
  void listener() {
    return switch (controller.state) {
      SuccessState(:final message) => {
          if (message != null) Alerts.showSuccess(context, message),
        },
      ErrorState() =>
        Alerts.showFailure(context, 'Erro ao carregar os serviços'),
      _ => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Serviços'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final result = await Modular.to
                  .pushNamed<ServiceModel>('/registration/services/save');

              if (result != null) {
                controller.addService(result);
              }
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
              onChanged: controller.filterServices,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: controller,
                builder: (_, state, child) {
                  return switch (state) {
                    SuccessState(:final List<ServiceModel> data) =>
                      ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final service = data[index];
                          return RegistrationCardWidget(
                            title: service.name,
                            subTitle: service.description,
                            color: colorScheme.outlineVariant,
                            onRemove: () async =>
                                await controller.deleteService(service),
                            onEdit: () async {
                              final result =
                                  await Modular.to.pushNamed<ServiceModel>(
                                '/registration/services/edit',
                                arguments: service,
                              );
                              if (result != null) {
                                controller.updateService(result);
                              }
                            },
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
