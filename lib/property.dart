class Property {
  String name;
  String id;
  int? position;
  int? price;
  int? rent;
  List<int>? multipliedRent;
  int numberOfHouses = 0;
  int? houseCost; // Added house cost field
  bool isMortgaged = false; // Added mortgage status field
  int? mortgageValue; // Added mortgage value field

  Property({
    required this.name,
    required this.id,
    this.position,
    this.price,
    this.rent,
    this.multipliedRent,
    this.houseCost,
    this.mortgageValue,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      name: json['name'] as String,
      id: json['id'] as String,
      position: json['position'] as int?,
      price: json['price'] as int?,
      rent: json['rent'] as int?,
      multipliedRent: (json['multipliedRent'] as List?)?.map((e) => e as int).toList(),
      houseCost: json['houseCost'] as int?,
      mortgageValue: json['mortgageValue'] as int?,
    );
  }

  int get rentWithHotel => rentWithHouses(5);

  int rentWithHouses(int numberOfHouses) {
    if (numberOfHouses == 5) {
      return rentWithHotel;
    } else if (numberOfHouses > 0 && numberOfHouses <= 4) {
      return multipliedRent?[numberOfHouses - 1] ?? 0;
    }
    return rent ?? 0;
  }

  void buyHouse() {
    if (numberOfHouses < 5) {
      numberOfHouses++;
    }
  }

  void mortgageProperty() {
    if (!isMortgaged) {
      isMortgaged = true;
    }
  }

  void unmortgageProperty() {
    if (isMortgaged) {
      isMortgaged = false;
    }
  }

  bool get canBuild {
    // Add your logic here for determining if a house can be built
    // For example:
    return !isMortgaged && numberOfHouses < 5;
  }

  int get currentRent => rentWithHouses(numberOfHouses);
}
