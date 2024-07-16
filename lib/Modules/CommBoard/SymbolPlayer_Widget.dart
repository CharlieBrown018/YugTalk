import 'package:flutter/material.dart';

class SymbolPlayer_Widget extends StatefulWidget {
  final List<Map<String, String>> selectedSymbols;  // Adding selectedSymbols as a parameter

  const SymbolPlayer_Widget({Key? key, required this.selectedSymbols}) : super(key: key);

  @override
  _SymbolPlayer_WidgetState createState() => _SymbolPlayer_WidgetState();
}

class _SymbolPlayer_WidgetState extends State<SymbolPlayer_Widget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.play_arrow, color: Colors.black,),
            padding: EdgeInsets.only(right: 40, left: 20),
            iconSize: 60,
            onPressed: () {
              _playSymbols(widget.selectedSymbols);  // Use the passed selectedSymbols
            },
          ),
          Expanded(
            child: Container(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.selectedSymbols.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    margin: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.selectedSymbols[index]['symbol']!,
                          style: TextStyle(fontSize: 35),
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.selectedSymbols[index]['word']!,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.black),
            padding: EdgeInsets.only(left: 40, right: 20),
            iconSize: 50,
            onPressed: () {
              setState(() {
                widget.selectedSymbols.clear();  // Clearing the symbols list
              });
            },
          ),
        ],
      ),
    );
  }

  void _playSymbols(List<Map<String, String>> symbols) {
    // Implement logic to play the selected symbols
    print('Playing symbols: $symbols');
  }
}
