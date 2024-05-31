import 'package:flutter_modular/flutter_modular.dart';

class CustomDrawerController {
  CustomDrawerController() : _selectedIndex = 0;

  final Map<int, void Function()> menus = {
    0: () => Modular.to.navigate('/home/'),
    1: () => Modular.to.navigate('/budgets/'),
    2: () => Modular.to.navigate('/service-orders/'),
    3: () => Modular.to.navigate('/registration/items/'),
    4: () => Modular.to.navigate('/registration/services/'),
    5: () => Modular.to.navigate('/registration/cars/'),
    6: () => Modular.to.navigate('/registration/costumers/'),
  };

  int _selectedIndex;
  int get selectedIndex => _selectedIndex;

  void updateSelectedAndNavigateToPage(int value) {
    _update(value);
    _navigate();
  }

  void _update(int value) => _selectedIndex = value;

  void Function()? _navigate() {
    if (menus.containsKey(selectedIndex)) {
      menus[selectedIndex]!();
    }
    return null;
  }

  void logout() => Modular.to.navigate('/auth/');
}
