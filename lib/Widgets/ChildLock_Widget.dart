import 'package:flutter/material.dart';
import 'package:gtext/gtext.dart';

import '../Modules/Home/Home_Mod.dart';

class ChildLock_Widget extends StatefulWidget {
  const ChildLock_Widget({Key? key}) : super(key: key);

  @override
  _ChildLock_WidgetState createState() => _ChildLock_WidgetState();
}

class _ChildLock_WidgetState extends State<ChildLock_Widget> {
  int _tapCount = 0;
  final String _temporaryPassword = '1234'; // Temporary password

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _incrementTapCount();
      },
      icon: const Icon(
        Icons.lock,
        size: 40,
      ),
    );
  }

  void _incrementTapCount() {
    setState(() {
      _tapCount++;
      if (_tapCount == 3) {
        _showPasswordDialog(context);
      }
    });
  }

  void _showPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String enteredPassword = ''; // Declare enteredPassword variable

        return AlertDialog(
          title: GText('Enter Password'),
          content: TextField(
            obscureText: true,
            decoration: InputDecoration(hintText: 'Password'),
            onChanged: (value) {
              // Update enteredPassword when the TextField changes
              enteredPassword = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Implement password validation here
                if (enteredPassword == _temporaryPassword) {
                  // Password is correct
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.pushReplacement( // Replace the current route with the HomeScreen
                    context,
                    MaterialPageRoute(builder: (context) => const Home_Mod()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: GText('Wrong password')),
                  );
                }
              },
              child: GText('Submit'),
            ),
          ],
        );
      },
    );
  }
}
