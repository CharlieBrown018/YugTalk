import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class LangToggle_Widget extends StatefulWidget {
  const LangToggle_Widget({Key? key}) : super(key: key);

  @override
  _LangToggle_WidgetState createState() => _LangToggle_WidgetState();
}

class _LangToggle_WidgetState extends State<LangToggle_Widget> {
  final String _temporaryPassword = '1234'; // Temporary password
  bool _isEnglishSelected = true;

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: 100.0,
      height: 40.0,
      valueFontSize: 20.0,
      toggleSize: 45.0,
      value: _isEnglishSelected,
      borderRadius: 30.0,
      padding: 8.0,
      showOnOff: true,
      activeText: "Eng",
      inactiveText: "Tag",
      activeTextColor: Colors.black,
      inactiveTextColor: Colors.black,
      activeColor: Colors.amber,
      inactiveColor: Colors.amber,
      onToggle: (val) {
        _showPasswordDialog(context, val);
      },
    );
  }

  void _toggleLanguage() {
    setState(() {
      _isEnglishSelected = !_isEnglishSelected;
    });
  }

  void _showPasswordDialog(BuildContext context, bool val) {
    if (_isEnglishSelected != val) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          String enteredPassword = ''; // Declare enteredPassword variable

          return AlertDialog(
            title: const Text('Enter Password'),
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
                    _toggleLanguage();
                    Navigator.of(context).pop(); // Close the dialog
                  } else {
                    print('Wrong password');
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          );
        },
      );
    } else {
      _toggleLanguage();
    }
  }
}
