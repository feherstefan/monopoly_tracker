# Monopoly Game Tracker

A Flutter application to help you keep track of all the essential elements in a Monopoly game. This app manages players' details, properties, and various game transactions like buying properties, building houses, mortgaging, and updating players' money.

## Features

- **Player Management**: Keep track of all players in the game, including their names, money, and owned properties.
- **Property Management**: View details of properties including price, rent at different development stages, and mortgage details.
- **Dynamic Transactions**: Update player's money, buy properties, build houses/hotels, and mortgage/unmortgage properties.
- **Game Progression**: Easily navigate through different players and properties to make changes as the game progresses.

## Getting Started

To get started with this app, ensure you have Flutter installed on your machine.

1. Clone the repository:
    ```
    git clone https://github.com/your-repository/monopoly-game-tracker.git
    ```
2. Navigate to the project directory:
    ```
    cd monopoly-game-tracker
    ```
3. Run the app:
    ```
    flutter run
    ```

## Application Structure

The app is structured into several Dart files, each serving a unique purpose:

- `main.dart`: The entry point of the application. It initializes the app and sets up the theme and navigation.
- `player.dart`: Defines the `Player` model with attributes like name, money, and owned properties.
- `property.dart`: Defines the `Property` model, including details like name, price, rent values, and mortgage status.
- `player_list.dart`: A widget to display a list of players and handle player selection and deletion.
- `property_list.dart`: A widget to display a list of properties and handle property selection.
- `player_details_screen.dart`: A detailed screen for individual player information and actions.
- `property_details_screen.dart`: A detailed view for individual property information.
- `money_dialog.dart`: A dialog widget to handle the addition or subtraction of money from a player.

## How to Use

- Add players to the game, specifying their names and initial money.
- Navigate through the list of players and properties.
- Update player details, buy or mortgage properties, and build houses or hotels as the game progresses.
- View detailed information about each player and property.

## Contributions

Contributions, issues, and feature requests are welcome. Feel free to check [issues page](https://github.com/your-repository/monopoly-game-tracker/issues) if you want to contribute.

## License

This project is licensed under the [MIT License](LICENSE).

---

Happy Gaming!
