import 'package:flutter/material.dart';
import 'property.dart';

class PropertyDetailsScreen extends StatelessWidget {
  final Property property;

  PropertyDetailsScreen({required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(property.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _propertyDetail('Name', property.name),
            _propertyDetail('ID', property.id.toString()),
            _propertyDetail('Position', property.position.toString()),
            _propertyDetail('Price', '\$${property.price}'),
            _propertyDetail('Base Rent', '\$${property.rent}'),
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

  Widget _propertyDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text('$label: ', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
