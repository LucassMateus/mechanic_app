import 'package:flutter/material.dart';

class MechanicAppLogo extends StatelessWidget {
  const MechanicAppLogo({required this.height, super.key});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/car-service-icon.png', height: height),
        const Text('Car Mechanic')
      ],
    );
  }
}
