import 'package:flutter/material.dart';
import 'package:mechanic_app/app/core/ui/components/mechanic_app_logo.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return NavigationDrawer(
      children: [
        SingleChildScrollView(
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                drawerHeader(colorScheme.primary),
                NavigationDrawerDestination(
                  icon: const Icon(Icons.home),
                  label: Text(
                    'Home',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                NavigationDrawerDestination(
                  icon: const Icon(Icons.home),
                  label: Text(
                    'Serviços',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                NavigationDrawerDestination(
                  icon: const Icon(Icons.home),
                  label: Text(
                    'Cadastro',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                NavigationDrawerDestination(
                  icon: const Icon(Icons.home),
                  label: Text(
                    'Gerencial',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                NavigationDrawerDestination(
                  icon: const Icon(Icons.home),
                  label: Text(
                    'Agenda',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ],
            ),
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
      child: MechanicAppLogo(),
    ),
  );
}
