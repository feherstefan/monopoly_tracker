import 'package:flutter/material.dart';
import 'player.dart';
import 'money_dialog.dart';
import 'property.dart';

class PlayerDetailsScreen extends StatelessWidget {
  final Player player;
  final List<Property> availableProperties;
  final Function(Player, int) onMoneyChanged;
  final Function(Player, Property) onBuyProperty;
  final Function(Player, Property) onBuyHouse;
  final Function(Player, Property) onMortgage;

  PlayerDetailsScreen({
    required this.player,
    required this.availableProperties,
    required this.onMoneyChanged,
    required this.onBuyProperty,
    required this.onBuyHouse,
    required this.onMortgage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(player.name),
      ),
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

  ListTile _buildMoneyTile(BuildContext context) {
    return ListTile(
      title: Text('Money: \$${player.money}'),
      trailing: IconButton(
        icon: Icon(Icons.add),
        onPressed: () => _showMoneyDialog(context, true),
      ),
    );
  }

  ListTile _buildPropertiesTile() {
    return ListTile(
      title: Text('Properties'),
      subtitle: Text(player.properties.isNotEmpty
          ? player.properties.map((prop) => prop.name).join(', ')
          : 'No properties'),
    );
  }

  ListTile _buildBuyPropertyTile() {
    return ListTile(
      title: Text('Buy Property'),
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

  ListTile _buildBuyHouseHotelTile() {
    return ListTile(
      title: Text('Buy House/Hotel'),
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

  ListTile _buildMortgageUnmortgageTile() {
    return ListTile(
      title: Text('Mortgage/Unmortgage'),
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

  ListTile _buildGetSalaryTile() {
    return ListTile(
      title: Text('Get Salary'),
      trailing: IconButton(
        icon: Icon(Icons.monetization_on),
        onPressed: () => onMoneyChanged(player, 200), // Assuming $200 as salary
      ),
    );
  }

  void _showMoneyDialog(BuildContext context, bool isAddingMoney) {
    showDialog(
      context: context,
      builder: (context) => MoneyDialog(
        onMoneyChanged: (amount) => onMoneyChanged(player, isAddingMoney ? amount : -amount),
      ),
    );
  }
}
