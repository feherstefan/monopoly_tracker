// Importing necessary Flutter material and custom classes
import 'package:flutter/material.dart';
import 'player.dart';
import 'money_dialog.dart';
import 'property.dart';

// PlayerDetailsScreen class displays detailed information about a player
class PlayerDetailsScreen extends StatelessWidget {
  // Variables to hold player details and functions for various actions
  final Player player;
  final List<Property> availableProperties;
  final Function(Player, int) onMoneyChanged;
  final Function(Player, Property) onBuyProperty;
  final Function(Player, Property) onBuyHouse;
  final Function(Player, Property) onMortgage;

  // Constructor to initialize the class with required data
  const PlayerDetailsScreen({super.key, 
    required this.player,
    required this.availableProperties,
    required this.onMoneyChanged,
    required this.onBuyProperty,
    required this.onBuyHouse,
    required this.onMortgage,
  });

  // Building the UI of the PlayerDetailsScreen
  @override
  Widget build(BuildContext context) {
    // Scaffold provides the structure for the screen
    return Scaffold(
      appBar: AppBar(
        title: Text(player.name),
      ),
      // ListView to display a list of options and information
      body: ListView(
        children: [
          _buildMoneyTile(context),
          _buildPropertiesTile(),
          _buildBuyPropertyTile(),
          _buildBuyHouseHotelTile(),
          _buildMortgageUnmortgageTile(),
          _buildGetSalaryTile(),
        ],
      ),
    );
  }

  // Widget to display and modify the player's money
  ListTile _buildMoneyTile(BuildContext context) {
    return ListTile(
      title: Text('Money: \$${player.money}'),
      trailing: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () => _showMoneyDialog(context, true),
      ),
    );
  }

  // Widget to display the player's properties
  ListTile _buildPropertiesTile() {
    return ListTile(
      title: const Text('Properties'),
      subtitle: Text(player.properties.isNotEmpty
          ? player.properties.map((prop) => prop.name).join(', ')
          : 'No properties'),
    );
  }

  // Widget to buy a property
  ListTile _buildBuyPropertyTile() {
    return ListTile(
      title: const Text('Buy Property'),
      trailing: PopupMenuButton<Property>(
        onSelected: (property) => onBuyProperty(player, property),
        itemBuilder: (context) => availableProperties
            .map(
              (property) => PopupMenuItem<Property>(
                value: property,
                child: Text('${property.name} (\$${property.price})'),
              ),
            )
            .toList(),
      ),
    );
  }

  // Widget to buy a house or hotel
  ListTile _buildBuyHouseHotelTile() {
    return ListTile(
      title: const Text('Buy House/Hotel'),
      trailing: PopupMenuButton<Property>(
        onSelected: (property) => onBuyHouse(player, property),
        itemBuilder: (context) => player.properties
            .where((property) => property.canBuild)
            .map(
              (property) => PopupMenuItem<Property>(
                value: property,
                child: Text('${property.name} (\$${property.houseCost})'),
              ),
            )
            .toList(),
      ),
    );
  }

  // Widget to mortgage or unmortgage properties
  ListTile _buildMortgageUnmortgageTile() {
    return ListTile(
      title: const Text('Mortgage/Unmortgage'),
      trailing: PopupMenuButton<Property>(
        onSelected: (property) => onMortgage(player, property),
        itemBuilder: (context) => player.properties
            .map(
              (property) => PopupMenuItem<Property>(
                value: property,
                child: Text('${property.name} (\$${property.mortgageValue})'),
              ),
            )
            .toList(),
      ),
    );
  }

  // Widget to get salary
  ListTile _buildGetSalaryTile() {
    return ListTile(
      title: const Text('Get Salary'),
      trailing: IconButton(
        icon: const Icon(Icons.monetization_on),
        onPressed: () => onMoneyChanged(player, 200), // Assuming $200 as salary
      ),
    );
  }

  // Function to show dialog for adding or subtracting money
  void _showMoneyDialog(BuildContext context, bool isAddingMoney) {
    showDialog(
      context: context,
      builder: (context) => MoneyDialog(
        onMoneyChanged: (amount) => onMoneyChanged(player, isAddingMoney ? amount : -amount),
      ),
    );
  }
}
