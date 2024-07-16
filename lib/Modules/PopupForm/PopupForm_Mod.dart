import 'package:flutter/material.dart';
import '/Modules/PopupForm/VideoPlayer_Widget.dart';
import '/Modules/PopupForm/AudioPlayer_Widget.dart';

class PopupForm_Mod extends StatelessWidget {
  final String symbol;
  final String word;
  final String description;
  final String audioPath;
  final String videoUrl;

  const PopupForm_Mod({
    required this.symbol,
    required this.word,
    required this.description,
    required this.audioPath,
    required this.videoUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 215, 215, 215).withOpacity(0.6),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 111, 67, 192),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.black, width: 3),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                      color: Colors.black,
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 865,
                        height: 420,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey,
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: VideoPlayerWidget(videoUrl: videoUrl),
                      ),
                      SizedBox(width: 20),
                      Column(
                        children: [
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color.fromARGB(255, 255, 255, 255),
                              border: Border.all(color: Colors.black, width: 3),
                            ),
                            child: Center(
                              child: Text(
                                symbol,
                                style: TextStyle(
                                  fontSize: 100,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color.fromARGB(255, 255, 255, 255),
                              border: Border.all(color: Colors.black, width: 3),
                            ),
                            child: AudioPlayerWidget(audioPath: audioPath),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 1085,
                      height: 215,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.black, width: 3),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            word,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 0, 0)),
                          ),
                          SizedBox(height: 10),
                          Text(
                            description,
                            style: TextStyle(fontSize: 18, color: const Color.fromARGB(179, 0, 0, 0)),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
