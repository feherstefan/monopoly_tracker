import 'package:flutter/material.dart';

class MoneyDialog extends StatefulWidget {
  final Function(int) onMoneyChanged;

  const MoneyDialog({super.key, required this.onMoneyChanged});

  @override
  _MoneyDialogState createState() => _MoneyDialogState();
}

class _MoneyDialogState extends State<MoneyDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add/Subtract Money'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(hintText: "Enter amount"),
        keyboardType: TextInputType.number,
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
            if (_controller.text.isNotEmpty) {
              int amount = int.tryParse(_controller.text) ?? 0;
              widget.onMoneyChanged(amount);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
