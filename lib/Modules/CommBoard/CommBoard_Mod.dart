import 'package:flutter/material.dart';
import '/Modules/CommBoard/SymbolPlayer_Widget.dart';
import '/Modules/CommBoard/CategoriesTiles_Widget.dart';

class CommBoard_Mod extends StatefulWidget {
  const CommBoard_Mod({Key? key}) : super(key: key);

  @override
  _CommBoard_ModState createState() => _CommBoard_ModState();
}

class _CommBoard_ModState extends State<CommBoard_Mod> {
  List<Map<String, String>> selectedSymbols = [];

  void onSymbolSelected(Map<String, String> symbolData) {
    setState(() {
      // Prevent adding duplicate symbols or implement your own logic
      if (!selectedSymbols.any((element) => element['symbol'] == symbolData['symbol'])) {
        selectedSymbols.add(symbolData);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20), // Padding outside the container
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 224, 224, 224), // Background color
          borderRadius: BorderRadius.circular(20), // Rounded corners
        ),
        padding: const EdgeInsets.all(5), // Padding inside the container
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 1, // Adjust flex values to control vertical space distribution
                    child: ListTile(
                      title: SymbolPlayer_Widget(selectedSymbols: selectedSymbols),
                    ),
                  ),
                  Expanded(
                    flex: 5, // Adjust flex values to control vertical space distribution
                    child: CategoriesTiles_Widget(onSymbolSelected: onSymbolSelected),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}