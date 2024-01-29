// Importing necessary Flutter material package and Property class
import 'package:flutter/material.dart';
import 'property.dart';

// PropertyDetailsScreen is a StatelessWidget that shows details of a specific property
class PropertyDetailsScreen extends StatelessWidget {
  // Property object whose details are to be displayed
  final Property property;

  // Constructor requiring a Property object
  const PropertyDetailsScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic visual layout structure of the screen
    return Scaffold(
      appBar: AppBar(
        title: Text(property.name), // Title of the AppBar is the name of the property
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // A series of rows each showing a label and corresponding value for property details
            _propertyDetail('Name', property.name),
            _propertyDetail('ID', property.id.toString()),
            _propertyDetail('Position', property.position.toString()),
            _propertyDetail('Price', '\$${property.price}'),
            _propertyDetail('Base Rent', '\$${property.rent}'),
            // Rent details with different numbers of houses or a hotel
            _propertyDetail('Rent with 1 house', '\$${property.rentWithHouses(1)}'),
            _propertyDetail('Rent with 2 houses', '\$${property.rentWithHouses(2)}'),
            _propertyDetail('Rent with 3 houses', '\$${property.rentWithHouses(3)}'),
            _propertyDetail('Rent with 4 houses', '\$${property.rentWithHouses(4)}'),
            _propertyDetail('Rent with hotel', '\$${property.rentWithHotel}'),
          ],
        ),
      ),
    );
  }

  // Helper widget to create a row for each property detail
  Widget _propertyDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // Bold label text
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          // Value text
          Text(value),
        ],
      ),
    );
  }
}
