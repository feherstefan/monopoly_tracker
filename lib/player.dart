import 'property.dart';

class Player {
  String name;
  int money;
  List<Property> properties;

  Player({required this.name, this.money = 1500, this.properties = const []});
}
