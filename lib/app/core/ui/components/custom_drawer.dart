import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/controllers/custom_drawer_controller.dart';
import 'package:mechanic_app/app/core/ui/components/mechanic_app_logo.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final controller = Modular.get<CustomDrawerController>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return NavigationDrawer(
      selectedIndex: controller.selectedIndex,
      onDestinationSelected: (index) {
        controller.updateSelectedAndNavigateToPage(index);
        setState(() {});
      },
      children: [
        // drawerHeader(colorScheme.primary),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: Text('Geral'),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.home_outlined),
          label: Text(
            'Home',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.receipt_long_outlined),
          label: Text(
            'Orçamentos',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.assignment_outlined),
          label: Text(
            'Ordens de Serviço',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        const Divider(),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: Text('Cadastro'),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.settings_outlined),
          label: Text(
            'Itens',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.build_outlined),
          label: Text(
            'Serviços',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.directions_car_filled_outlined),
          label: Text(
            'Carros',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.person_2_outlined),
          label: Text(
            'Clientes',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        const Divider(),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: Text('Gerencial'),
        ),
        NavigationDrawerDestination(
          enabled: false,
          icon: const Icon(Icons.business_center_outlined),
          label: Text(
            'Gerencial',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        NavigationDrawerDestination(
          enabled: false,
          icon: const Icon(Icons.calendar_month_outlined),
          label: Text(
            'Agenda',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        const Divider(),
        SizedBox(
          width: 50,
          child: TextButton.icon(
            onPressed: controller.logout,
            label: SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.logout_outlined),
                    Text(
                      'Sair',
                      style: TextStyle(color: colorScheme.primary),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

Widget drawerHeader(Color color) {
  return Container(
    height: 150,
    decoration: BoxDecoration(
      // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
      color: color,
    ),
    child: const Center(
      child: MechanicAppLogo(height: 80),
    ),
  );
}
