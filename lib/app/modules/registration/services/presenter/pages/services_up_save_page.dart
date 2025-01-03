import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/ui/base_state_page.dart/base_state_page.dart';
import 'package:mechanic_app/app/core/ui/components/registration_widget.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/dtos/service_save_dto.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/models/service_model.dart';

import '../../../../../core/state/base_state.dart';
import '../../../../../core/theme/theme_config.dart';
import '../../../../../core/ui/components/custom_text_field.dart';
import '../../../../../core/ui/components/error_widget.dart';
import '../../../../../core/ui/components/loader_widget.dart';
import '../../domain/dtos/service_car_details_dto.dart';
import '../controllers/services_up_save_controller.dart';

class ServicesUpSavePage extends StatefulWidget {
  const ServicesUpSavePage({super.key, this.service, required this.isUpdate})
      : assert((isUpdate && service != null) || !isUpdate);

  final ServiceModel? service;
  final bool isUpdate;

  @override
  State<ServicesUpSavePage> createState() => _ServicesUpSavePageState();
}

class _ServicesUpSavePageState
    extends BaseStatePage<ServicesUpSavePage, ServicesUpSaveController> {
  ServiceModel? get service => widget.service;
  bool get isUpdate => widget.isUpdate;
  final TextEditingController nameEC = TextEditingController();
  final TextEditingController descriptionEC = TextEditingController();
  ServiceSaveDto get serviceSaveDto => controller.serviceSaveDto;

  @override
  void onReady() {
    nameEC.text = service?.name ?? '';
    descriptionEC.text = service?.description ?? '';

    controller.init(service);
  }

  @override
  void onClose() {
    nameEC.dispose();
    descriptionEC.dispose();
    super.onClose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isUpdate
              ? 'Serviço: ${service!.id} - ${service!.name}'
              : 'Cadastrar Serviço',
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.close,
                size: 28,
                color: ThemeConfig.theme.colorScheme.error,
              ),
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: controller,
        builder: (_, state, child) {
          return switch (state) {
            SuccessState() => _buildForm(),
            LoadingState() => const LoaderWidget(),
            ErrorState(:final exception, :final message) =>
              CustomErrorWidget(message, exception),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }

  Widget _buildForm() {
    return RegistrationWidget(
      onSaved: _upSaveService,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            children: [
              CustomTextFormField(
                label: 'Nome',
                controller: nameEC,
                onChanged: serviceSaveDto.setName,
              ),
              CustomTextFormField(
                label: 'Descrição',
                controller: descriptionEC,
                onChanged: serviceSaveDto.setDescription,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    label: const Text('Items'),
                    icon: const Icon(Icons.add),
                    onPressed: () async {
                      final results =
                          await Modular.to.pushNamed<Set<ItemModel>>(
                        '/registration/services/items',
                        arguments: controller.itemsFromService,
                      );

                      if (results != null) {
                        controller.serviceSaveDto.items = results;
                      }
                    },
                  ),
                  ElevatedButton.icon(
                    label: const Text('Preços por carro'),
                    icon: const Icon(Icons.car_repair_outlined),
                    onPressed: () async {
                      final results =
                          await Modular.to.pushNamed<Set<ServiceCarDetailsDto>>(
                        '/registration/services/prices-per-car',
                        arguments: controller.carsDetailsFromService,
                      );

                      if (results != null) {
                        controller.serviceSaveDto.carsDetails = results;
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _upSaveService() async {
    if (isUpdate) {
      await controller.updateService();

      if (controller.state is SuccessState && mounted) {
        Navigator.pop(context, controller.service);
      }
    } else {
      final savedService = await controller.saveService();

      if (controller.state is SuccessState && mounted) {
        Navigator.pop(context, savedService);
      }
    }
  }
}
