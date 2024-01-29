// Importing necessary Flutter material package and custom Player class
import 'package:flutter/material.dart';
import 'player.dart';

// PlayerList class is a StatelessWidget that creates a list view of players
class PlayerList extends StatelessWidget {
  // List of Player objects to display
  final List<Player> players;
  // Functions to handle delete and navigate actions
  final Function onDelete;
  final Function onNavigate;

  // Constructor requiring a list of players and functions for onDelete and onNavigate actions
  const PlayerList({super.key, required this.players, required this.onDelete, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    // Building a ListView using the ListView.builder constructor
    return ListView.builder(
      // itemCount is the number of players in the list
      itemCount: players.length,
      itemBuilder: (context, index) {
        // Each item in the list is a ListTile widget
        return ListTile(
          // Displaying the player's name
          title: Text(players[index].name),
          // Displaying the player's money
          subtitle: Text('Money: \$${players[index].money}'),
          // Trailing icon to delete the player
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            // onDelete callback function is called when the delete icon is tapped
            onPressed: () => onDelete(index),
          ),
          // onNavigate callback function is called when the ListTile is tapped
          onTap: () => onNavigate(players[index]),
        );
      },
    );
  }
}
