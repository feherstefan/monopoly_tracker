// Importing Flutter's foundation library for ChangeNotifier and a custom Property class
import 'package:flutter/foundation.dart';
import 'property.dart';

// PlayerModel class that notifies listeners of changes in player data
class PlayerModel extends ChangeNotifier {
  // Player's name
  String name;
  // Player's current amount of money
  int money;
  // List of properties owned by the player
  List<Property> properties;

  // Constructor with required name parameter, and optional money and properties parameters
  PlayerModel({required this.name, this.money = 1500, this.properties = const []});

  // Method to update the player's money
  void updateMoney(int amount) {
    money += amount;
    // Notifying all listeners about the change in money
    notifyListeners();
  }

  // Method to handle the buying of a property
  void buyProperty(Property property) {
    // Checks if the property price is not null and if the player has enough money
    if (property.price != null && money >= property.price!) {
      money -= property.price!;
      properties.add(property);
      // Notifying listeners about the changes in properties and money
      notifyListeners();
    }
  }

  // Placeholder for other methods. Remember to call notifyListeners() when updating the state
  // Add other methods as needed and call notifyListeners() when updating the state
}
