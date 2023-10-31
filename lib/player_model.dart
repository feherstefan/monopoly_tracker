import 'package:flutter/foundation.dart';
import 'property.dart';

class PlayerModel extends ChangeNotifier {
  String name;
  int money;
  List<Property> properties;

  PlayerModel({required this.name, this.money = 1500, this.properties = const []});

  void updateMoney(int amount) {
    money += amount;
    notifyListeners();
  }

  void buyProperty(Property property) {
    if (property.price != null && money >= property.price!) {
      money -= property.price!;
      properties.add(property);
      notifyListeners();
    }
  }

  // Add other methods as needed and call notifyListeners() when updating the state
}
