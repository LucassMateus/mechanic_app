import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';
import 'package:mechanic_app/app/core/theme/theme_config.dart';
import 'package:mechanic_app/app/core/ui/components/error_widget.dart';
import 'package:mechanic_app/app/core/ui/components/registration_widget.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/dtos/customer_save_dto.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/models/customer_model.dart';
import 'package:mechanic_app/app/modules/registration/customers/presenter/controllers/customer_up_save_controller.dart';

import '../../../../../core/ui/alerts/alerts.dart';
import '../../../../../core/ui/base_state_page.dart/base_state_page.dart';
import '../../../../../core/ui/components/custom_text_field.dart';
import '../../../../../core/ui/components/loader_widget.dart';
import '../../../../../core/ui/components/multi_select_dialog.dart';
import '../../../cars/domain/models/car_model.dart';
import '../widgets/customer_cars_widget.dart';

class CustomerUpSavePage extends StatefulWidget {
  final CustomerModel? customer;
  final bool isUpdate;

  const CustomerUpSavePage({super.key, this.customer, required this.isUpdate})
      : assert((isUpdate && customer != null) || !isUpdate);

  @override
  State<CustomerUpSavePage> createState() => _CustomerUpSavePageState();
}

class _CustomerUpSavePageState
    extends BaseStatePage<CustomerUpSavePage, CustomerUpSaveController> {
  CustomerModel? get customer => widget.customer;
  bool get isUpdate => widget.isUpdate;

  late TextEditingController nameEC;
  late TextEditingController emailAddressEC;
  late TextEditingController phoneEC;

  @override
  void onReady() {
    controller.init(customer?.cars ?? []);

    nameEC = TextEditingController(text: customer?.name);
    emailAddressEC = TextEditingController(text: customer?.email);
    phoneEC = TextEditingController(text: customer?.phoneNumber);
  }

  @override
  void listener() {
    return switch (controller.state) {
      SuccessState(:final message) => {
          if (message != null) Alerts.showSuccess(context, message),
        },
      ErrorState(:final exception, :final message) =>
        Alerts.showFailure(context, message ?? exception.toString()),
      _ => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isUpdate
              ? 'Cliente: ${customer!.id} - ${customer!.name}'
              : 'Cadastrar Cliente',
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
      onSaved: _upSaveCustomer,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            children: [
              CustomTextFormField(
                label: 'Nome',
                controller: nameEC,
              ),
              CustomTextFormField(
                label: 'Telefone',
                controller: phoneEC,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter()
                ],
              ),
              CustomTextFormField(
                label: 'Email',
                controller: emailAddressEC,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Carros do Cliente:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  OutlinedButton(
                    onPressed: () => _showCarsDialog(customer),
                    child: const Text('Selecionar Carros'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomerCarsWidget(cars: controller.selectedCars),
            ],
          ),
        );
      },
    );
  }

  void _upSaveCustomer() async {
    if (isUpdate) {
      final updatedCustomer = CustomerModel(
        id: customer!.id,
        name: nameEC.text,
        email: emailAddressEC.text,
        phoneNumber: phoneEC.text,
        cars: controller.selectedCars,
      );

      await controller.updateCustomer(updatedCustomer);

      if (controller.state is SuccessState && mounted) {
        Navigator.pop(context, updatedCustomer);
      }
    } else {
      final newCustomer = CustomerSaveDto(
        name: nameEC.text,
        email: emailAddressEC.text,
        phoneNumber: phoneEC.text,
        cars: controller.selectedCars,
      );

      final savedCustomer = await controller.saveCustomer(newCustomer);

      if (controller.state is SuccessState && mounted) {
        Navigator.pop(context, savedCustomer);
      }
    }
  }

  void _showCarsDialog([CustomerModel? customer]) async {
    final List<CarModel> items = controller.cars;

    final List<CarModel>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog<CarModel>(
          title: 'Selecione os carros',
          items: items,
          selectedItems: controller.selectedCars,
          itemTextBuilder: (item) {
            return '${item.brand} | ${item.model} | ${item.year}';
          },
          // onItemChange: (item, isSelected) {},
          onSearchChanged: controller.filterCars,
        );
      },
    );

    if (results != null) {
      controller.setSelectedCars(results);
    }
  }
}
