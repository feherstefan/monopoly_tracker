import 'player.dart';

class Property {
  // Basic property details
  String name;
  String id;
  String group; // Group the property belongs to
  int? position;
  int? price;
  int? rent;
  List<int>? multipliedRent; // Rent values depending on the number of houses
  int numberOfHouses = 0;
  int? houseCost; // Cost for buying a house on the property
  bool isMortgaged = false; // Tracks if the property is mortgaged
  int? mortgageValue; // The value of mortgaging the property

  // Constructor for initializing the property
  Property({
    required this.name,
    required this.id,
    required this.group,
    this.position,
    this.price,
    this.rent,
    this.multipliedRent,
    this.houseCost,
    this.mortgageValue,
  });

  // Factory constructor to create a Property from a JSON map
  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      name: json['name'] as String,
      id: json['id'] as String,
      group: json['group'] as String, // Ensure 'group' is included in your JSON
      position: json['position'] as int?,
      price: json['price'] as int?,
      rent: json['rent'] as int?,
      multipliedRent: (json['multipliedRent'] as List?)?.map((e) => e as int).toList(),
      houseCost: json['houseCost'] as int?,
      mortgageValue: json['mortgageValue'] as int?,
    );
  }

  // Getter to calculate the rent when a hotel is present
  int get rentWithHotel => rentWithHouses(5);

  // Method to calculate rent based on the number of houses
  int rentWithHouses(int numberOfHouses) {
    if (numberOfHouses == 5) { // Assuming 5 means a hotel
      return rentWithHotel;
    } else if (numberOfHouses > 0 && numberOfHouses <= 4) {
      return multipliedRent?[numberOfHouses - 1] ?? 0;
    }
    return rent ?? 0;
  }

  // Method to buy a house on the property
  void buyHouse() {
    if (numberOfHouses < 5) {
      numberOfHouses++;
    }
  }

  // Method to handle the financial aspect of mortgaging a property
  void mortgageProperty(Player player) {
    if (!isMortgaged && mortgageValue != null) {
      isMortgaged = true;
      player.money += mortgageValue!; // Adding mortgage value to player's money
      // Notify listeners or update state as needed
    }
  }

  // Method to include a financial transaction in unmortgaging the property
  void unmortgageProperty(Player player) {
    if (isMortgaged && mortgageValue != null) {
      isMortgaged = false;
      player.money -= mortgageValue!; // Deducting the mortgage value from player's money
      // Here you might consider adding an additional interest or fee for unmortgaging
      // Notify listeners or update state as needed
    }
  }

  // Logic to determine if a house can be built on this property
  bool get canBuild {
    return !isMortgaged && numberOfHouses < 5;
  }

  // Getter to return the current rent based on the number of houses
  int get currentRent => rentWithHouses(numberOfHouses);
}
