import 'package:flutter/material.dart';
import 'property.dart';
import 'dart:math';

class PropertyList extends StatelessWidget {
  final List<Property> properties;
  final Function(Property) onNavigate;

  const PropertyList({super.key, required this.properties, required this.onNavigate});


Color _groupColor(String groupName) {
  final hash = groupName.codeUnits.fold(0, (prev, element) => prev + element);
  final random = Random(hash);
  return Color.fromRGBO(
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
    1,
  );
}

  @override
  Widget build(BuildContext context) {
    // Step 3: Update PropertyList Widget
    return Scaffold(
      appBar: AppBar(
        title: const Text('Properties'),
      ),
      body: ListView.builder(
        itemCount: properties.length,
        itemBuilder: (context, index) {
          // Get color for the property group
          Color groupColor = _groupColor(properties[index].group);

          return Card(
            child: ListTile(
              title: Text(properties[index].name),
              subtitle: Text('\$${properties[index].price}'),
              onTap: () => onNavigate(properties[index]),
              tileColor: groupColor.withOpacity(0.2), // Apply group color with some transparency
            ),
          );
        },
      ),
    );
  }
}
