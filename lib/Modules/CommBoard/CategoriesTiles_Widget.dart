import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package
import 'package:tab_container/tab_container.dart';
import '../../Models/word.dart'; // Import the Word model
import '/Modules/PopupForm/PopupForm_Mod.dart';
import '/Modules/PopupForm/VideoPlayer_Widget.dart';
import '/Modules/PopupForm/AudioPlayer_Widget.dart';

class CategoriesTiles_Widget extends StatelessWidget {
  final Function(Map<String, String>) onSymbolSelected;

  const CategoriesTiles_Widget({Key? key, required this.onSymbolSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance.collection('word').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading data: ${snapshot.error}'));
        } else {
          final List<Word> words = snapshot.data!.docs.map((doc) {
            final data = doc.data();
            return Word(
              wordID: doc.id,
              wordName: data['wordName'],
              wordDesc: data['wordDesc'],
              wordImage: data['wordImage'],
              wordAudio: data['wordAudio'],
              wordVideo: data['wordVideo'],
            );
          }).toList();

          if (words.isEmpty) {
            return Center(child: Text('No words found.'));
          }

          return TabContainer(
            color: Theme.of(context).colorScheme.secondary,
            tabs: List.generate(
              words.length,
                  (index) => Tab(text: 'Category ${index + 1}'),
            ),
            children: List.generate(
              words.length,
                  (index) => _buildCategoryTab(context, words[index]),
            ),
          );
        }
      },
    );
  }

  Widget _buildCategoryTab(BuildContext context, Word word) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: 1, // We only have one word per tab
      itemBuilder: (context, index) {
        return _buildCard(context, word);
      },
    );
  }

  Widget _buildCard(BuildContext context, Word word) {
    return GestureDetector(
      onTap: () => onSymbolSelected({
        'symbol': word.wordName,
        'word': word.wordDesc,
      }),
      onLongPress: () {
        Future.delayed(Duration(milliseconds: 100), () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return PopupForm_Mod(
                symbol: word.wordImage.toString(),
                word: word.wordName,
                description: word.wordDesc,
                audioPath: word.wordAudio,
                videoUrl: word.wordVideo,
              );
            },
          );
        });
      },
      child: Card(
        elevation: 2,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(Icons.volume_up),
                iconSize: 50,
                onPressed: () {
                  // Play audio associated with the symbol
                },
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(word.wordName, style: TextStyle(fontSize: 24)),
                  Text(word.wordDesc, style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
