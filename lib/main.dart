import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'player.dart';
import 'player_list.dart';
import 'player_details_screen.dart';
import 'property.dart';
import 'property_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monopoly Game Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Player> players = [];
  List<Property> properties = [];
  List<Property> availableProperties = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProperties().then((loadedProperties) {
      setState(() {
        properties = loadedProperties;
        availableProperties = List.from(properties);
        isLoading = false;
      });
    });
  }

Future<List<Property>> loadProperties() async {
  final jsonString = await rootBundle.loadString('assets/properties.json');
  final jsonResponse = json.decode(jsonString);
  final List<dynamic> jsonProperties = jsonResponse['properties'];
  return jsonProperties.map((json) => Property.fromJson(json)).toList();
}


  void _addNewPlayer(String playerName) {
    setState(() {
      players.add(Player(name: playerName));
    });
  }

  void _deletePlayer(int index) {
    setState(() {
      players.removeAt(index);
    });
  }

  void _updatePlayerMoney(Player player, int amount) {
    setState(() {
      player.money += amount;
    });
  }

  void _buyProperty(Player player, Property property) {
    if (property.price != null && player.money >= property.price! && availableProperties.contains(property)) {
      setState(() {
        player.money -= property.price!;
        player.properties.add(property);
        availableProperties.remove(property);
      });
    }
  }

  void _buyHouse(Player player, Property property) {
    if (property.houseCost != null && player.money >= property.houseCost! && player.properties.contains(property)) {
      setState(() {
        player.money -= property.houseCost!;
        // Here you might want to do something with the property, like add a house.
      });
    }
  }

  void _mortgageProperty(Player player, Property property) {
    if (property.mortgageValue != null && player.properties.contains(property) && !property.isMortgaged) {
      setState(() {
        player.money += property.mortgageValue!;
        property.isMortgaged = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Monopoly Game Tracker'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monopoly Game Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
            ListTile(
              title: const Text('Properties'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PropertyList(properties: availableProperties, onNavigate: (property) {
                    // Define what you want to do when a property is navigated to
                  })),
                );
              },
            ),
          ],
        ),
      ),
      body: PlayerList(
        players: players,
        onDelete: _deletePlayer,
        onNavigate: _navigateToPlayer,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPlayerDialog,
        tooltip: 'Add Player',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToPlayer(Player player) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlayerDetailsScreen(
          player: player,
          onMoneyChanged: _updatePlayerMoney,
          availableProperties: availableProperties,
          onBuyProperty: _buyProperty,
          onBuyHouse: _buyHouse,
          onMortgage: _mortgageProperty,
          // Add other required parameters here
        ),
      ),
    );
  }

  void _showAddPlayerDialog() {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Player'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Enter player's name"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _addNewPlayer(controller.text);
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
