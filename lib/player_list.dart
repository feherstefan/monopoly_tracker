import 'package:flutter/material.dart';
import 'player.dart';

class PlayerList extends StatelessWidget {
  final List<Player> players;
  final Function onDelete;
  final Function onNavigate;

  PlayerList({required this.players, required this.onDelete, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(players[index].name),
          subtitle: Text('Money: \$${players[index].money}'),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => onDelete(index),
          ),
          onTap: () => onNavigate(players[index]),
        );
      },
    );
  }
}
