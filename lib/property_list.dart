// Importing necessary Flutter material package and Property class
import 'package:flutter/material.dart';
import 'property.dart';

// PropertyList is a StatelessWidget for displaying a list of properties
class PropertyList extends StatelessWidget {
  // List of Property objects to display
  final List<Property> properties;
  // Function to handle navigation when a property is tapped
  final Function(Property) onNavigate;

  // Constructor with required properties list and onNavigate function
  const PropertyList({super.key, required this.properties, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic visual layout structure of the screen
    return Scaffold(
      appBar: AppBar(
        title: const Text('Properties'), // AppBar title
      ),
      // ListView.builder creates a list of items from the properties list
      body: ListView.builder(
        itemCount: properties.length, // Number of items in the list
        itemBuilder: (context, index) {
          // Each item is wrapped in a Card for a neater appearance
          return Card(
            child: ListTile(
              title: Text(properties[index].name), // Property name displayed as the title
              subtitle: Text('\$${properties[index].price}'), // Property price displayed as the subtitle
              // onTap triggers the onNavigate function passing the selected property
              onTap: () => onNavigate(properties[index]),
            ),
          );
        },
      ),
    );
  }
}
