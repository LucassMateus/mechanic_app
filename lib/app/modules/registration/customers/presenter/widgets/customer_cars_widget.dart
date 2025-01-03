import 'package:flutter/material.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';

class CustomerCarsWidget extends StatefulWidget {
  final List<CarModel> cars;

  const CustomerCarsWidget({super.key, required this.cars});

  @override
  State<CustomerCarsWidget> createState() => _CustomerCarsWidgetState();
}

class _CustomerCarsWidgetState extends State<CustomerCarsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.cars.map((car) => _carWidget(car)).toList(),
    );
  }

  Widget _carWidget(CarModel car) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          leading: const Icon(Icons.car_repair_outlined, size: 40),
          title: Text('${car.model} - ${car.year}'),
          subtitle: Text(car.brand),
          // trailing: IconButton(
          //   icon: const Icon(Icons.delete),
          //   onPressed: () {
          //     setState(() {
          //       widget.cars.remove(car);
          //     });
          //   },
          // ),
        ),
      ),
    );
  }
}
