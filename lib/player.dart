// Importing the Property class to be used as a type for the properties list.
import 'property.dart';

// The Player class, which will represent each player in your application.
class Player {
  // The player's name.
  String name;
  // The player's current amount of money, defaulting to 1500 if not specified.
  int money;
  // A list of Property objects representing properties owned by the player.
  List<Property> properties;

  // Constructor for the Player class.
  // The name parameter is required.
  // The money parameter has a default value of 1500.
  // The properties parameter is optional and defaults to an empty list if not provided.
  Player({required this.name, this.money = 1500, List<Property>? properties})
    : properties = properties ?? [];
}
