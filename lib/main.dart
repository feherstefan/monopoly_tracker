// Import necessary Dart and Flutter packages
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

// Import custom classes for the application
import 'player.dart';
import 'player_list.dart';
import 'player_details_screen.dart';
import 'property.dart';
import 'property_list.dart';

// Entry point of the Flutter application
void main() {
  runApp(const MyApp());
}

// MyApp is the root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monopoly Game Tracker',
      // Dark theme settings
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        colorScheme: const ColorScheme.dark(
          primary: Colors.blue,
          secondary: Colors.blueAccent, // Previously known as accentColor
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          color: Colors.blueGrey[900],
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blueAccent,
        ),
        // Add other dark theme customizations here
      ),
      // Enforce dark theme
      themeMode: ThemeMode.dark,
      home: const MyHomePage(),
    );
  }
}

// MyHomePage is the main screen of the app
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// State for MyHomePage
class _MyHomePageState extends State<MyHomePage> {
  // List to store players and properties
  List<Player> players = [];
  List<Property> properties = [];
  List<Property> availableProperties = [];
  // Flag to check if data is still loading
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Load properties from a JSON file
    loadProperties().then((loadedProperties) {
      setState(() {
        properties = loadedProperties;
        availableProperties = List.from(properties);
        isLoading = false;
      });
    });
  }

  // Function to load properties from a JSON asset
  Future<List<Property>> loadProperties() async {
    final jsonString = await rootBundle.loadString('assets/properties.json');
    final jsonResponse = json.decode(jsonString);
    final List<dynamic> jsonProperties = jsonResponse['properties'];
    return jsonProperties.map((json) => Property.fromJson(json)).toList();
  }

  // Function to add a new player
  void _addNewPlayer(String playerName) {
    setState(() {
      players.add(Player(name: playerName));
    });
  }

  // Function to delete a player
  void _deletePlayer(int index) {
    setState(() {
      players.removeAt(index);
    });
  }

  // Function to update a player's money
  void _updatePlayerMoney(Player player, int amount) {
    setState(() {
      player.money += amount;
    });
  }

  // Function to handle property buying
  void _buyProperty(Player player, Property property) {
    if (property.price != null && player.money >= property.price! && availableProperties.contains(property)) {
      setState(() {
        player.money -= property.price!;
        player.properties.add(property);
        availableProperties.remove(property);
      });
    }
  }

  // Function to handle buying houses or a hotel on a property
  void _buyHouse(Player player, Property property) {
    if (property.houseCost != null && player.money >= property.houseCost! && player.properties.contains(property)) {
      setState(() {
        player.money -= property.houseCost!;
        
        // Check if the property can still have houses added, or if it's time for a hotel
        if (property.numberOfHouses < 4) {
          // Add a house if less than 4 houses
          property.numberOfHouses++;
        } else if (property.numberOfHouses == 4) {
          // Convert to a hotel if 4 houses already present
          // Assuming the game logic that 4 houses = 1 hotel
          property.numberOfHouses = 5; // 5 could signify a hotel
        }
      });
    }
  }

  // Function to mortgage a property
  void _mortgageProperty(Player player, Property property) {
    if (property.mortgageValue != null && player.properties.contains(property) && !property.isMortgaged) {
      setState(() {
        player.money += property.mortgageValue!;
        property.isMortgaged = true;
      });
    }
  }

  // Building the UI for the app
  @override
  Widget build(BuildContext context) {
    // Display a loading indicator while data is being loaded
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

    // Main layout when data is loaded
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
        // Navigation drawer with menu options
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
                // Navigate to the property list screen
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PropertyList(properties: availableProperties, onNavigate: (property) {
                    // Define actions when a property is navigated to
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

  // Function to navigate to the player details screen
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

  // Function to show dialog for adding a new player
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
