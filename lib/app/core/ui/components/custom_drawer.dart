import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/ui/components/mechanic_app_logo.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return NavigationDrawer(
      onDestinationSelected: (index) {
        debugPrint(index.toString());
        switch(index) {
          case 2:
          Modular.to.navigate('/items');
        }
      },
      children: [
        drawerHeader(colorScheme.primary),
        NavigationDrawerDestination(
          icon: const Icon(Icons.home_outlined),
          label: Text(
            'Home',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.construction_outlined),
          label: Text(
            'Serviços',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.assignment_outlined),
          label: Text(
            'Cadastro',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.business_center_outlined),
          label: Text(
            'Gerencial',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.calendar_month_outlined),
          label: Text(
            'Agenda',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}

Widget drawerHeader(Color color) {
  return Container(
    height: 200,
    decoration: BoxDecoration(
      color: color,
    ),
    child: const Center(
      child: MechanicAppLogo(height: 80),
    ),
  );
}
