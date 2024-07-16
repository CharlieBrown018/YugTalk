import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});
        }
      });
    _controller.setLooping(true);
    _controller.addListener(_updateState);  // Use named method for listener
  }

  void _updateState() {
    if (mounted) {  // Check if the widget is still mounted
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_updateState);  // Remove listener first
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.black,
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                VideoPlayer(_controller),
                _buildBottomBar(),
              ],
            ),
          )
        : CircularProgressIndicator(),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      color: Colors.black54,
      height: 50,  // Fixed height for the control bar
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _controller.value.isPlaying ? _controller.pause() : _controller.play();
              });
            },
          ),
          Expanded(
            child: Slider(
              activeColor: Colors.red,
              value: _controller.value.position.inSeconds.toDouble(),
              min: 0,
              max: _controller.value.duration.inSeconds.toDouble(),
              onChanged: (double value) {
                _controller.seekTo(Duration(seconds: value.toInt()));
              },
            ),
          ),
          DropdownButton<double>(
            underline: SizedBox(),
            value: 1.0,  // Default speed
            icon: Icon(Icons.speed, color: Colors.white),
            dropdownColor: Colors.black54,
            onChanged: (double? newValue) {
              if (newValue != null) {
                setState(() {
                  _controller.setPlaybackSpeed(newValue);
                });
              }
            },
            items: <double>[0.5, 1.0, 1.5, 2.0].map<DropdownMenuItem<double>>((double value) {
              return DropdownMenuItem<double>(
                value: value,
                child: Text("${value}x", style: TextStyle(color: Colors.white)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
