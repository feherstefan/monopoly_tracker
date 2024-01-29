// Importing the necessary Flutter material package
import 'package:flutter/material.dart';

// MoneyDialog is a StatefulWidget which allows for dynamic changes in the UI based on user interaction.
class MoneyDialog extends StatefulWidget {
  // A function callback to handle the change in money. It takes an integer as a parameter.
  final Function(int) onMoneyChanged;

  // Constructor with required fields. The `key` is optional and used for identifying the widget in the widget tree.
  const MoneyDialog({super.key, required this.onMoneyChanged});

  @override
  _MoneyDialogState createState() => _MoneyDialogState();
}

// The state class for MoneyDialog, handling the state and behavior of the dialog.
class _MoneyDialogState extends State<MoneyDialog> {
  // Controller for the text field to handle input.
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // Initializing the text controller.
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    // Disposing of the controller when the widget is removed from the widget tree to avoid memory leaks.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Building the UI of the dialog.
    return AlertDialog(
      title: const Text('Add/Subtract Money'),
      content: TextField(
        // Using the previously defined text controller.
        controller: _controller,
        decoration: const InputDecoration(hintText: "Enter amount"),
        // Setting the keyboard type to numeric for easy numeric input.
        keyboardType: TextInputType.number,
      ),
      actions: <Widget>[
        TextButton(
          // Button to cancel and close the dialog.
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          // Button to confirm the action. It triggers the onMoneyChanged function with the entered amount.
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              // Parsing the entered string to an integer. It defaults to 0 if parsing fails.
              int amount = int.tryParse(_controller.text) ?? 0;
              // Calling the provided callback function with the parsed amount.
              widget.onMoneyChanged(amount);
              // Closing the dialog after the action is performed.
              Navigator.of(context).pop();
            }
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
