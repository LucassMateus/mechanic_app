import 'package:flutter/material.dart';

class MechanicAppLogo extends StatelessWidget {
  const MechanicAppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/car-service-icon.png', height: 150),
        const Text('Car Mechanic')
      ],
    );
  }
}
