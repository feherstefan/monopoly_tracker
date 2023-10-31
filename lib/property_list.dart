import 'package:flutter/material.dart';
import 'property.dart';

class PropertyList extends StatelessWidget {
  final List<Property> properties;
  final Function(Property) onNavigate;

  PropertyList({required this.properties, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Properties'),
      ),
      body: ListView.builder(
        itemCount: properties.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(properties[index].name),
              subtitle: Text('\$${properties[index].price}'),
              onTap: () => onNavigate(properties[index]),
            ),
          );
        },
      ),
    );
  }
}
