import 'package:flutter/material.dart';
class ProfileInfoPage extends StatefulWidget {
  final String label; // Label for the text field (Email, Name, Phone)
  final String initialValue; // Initial value for the text field
  final Function(String) onChange; // Callback for value change

  const ProfileInfoPage({super.key, required this.label, required this.initialValue, required this.onChange}); // Constructor

  @override
  State<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: widget.label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
            readOnly: true,
          ),
          Positioned(
            right: 10,
            top: 4,
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Change ${widget.label}'),
                    content: TextField(
                      controller: _controller,
                      decoration: InputDecoration(labelText: 'Enter new ${widget.label.toLowerCase()}'),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          widget.onChange(_controller.text); // Call the callback with the new value
                          Navigator.of(context).pop();
                        },
                        child: const Text('Change'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text(
                'CHANGE',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
