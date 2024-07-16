import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioPath;

  const AudioPlayerWidget({Key? key, required this.audioPath}) : super(key: key);

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer.open(
      Audio(widget.audioPath),
      autoStart: false,
      showNotification: true,
    );

    _audioPlayer.isPlaying.listen((isPlaying) {
      if (mounted) {
        setState(() {
          _isPlaying = isPlaying;
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
      _audioPlayer.seek(Duration.zero);  // Reset audio to the beginning when paused
    } else {
      _audioPlayer.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(_isPlaying ? Icons.volume_up : Icons.volume_down, color: Colors.black),
      onPressed: _togglePlayPause,
      tooltip: _isPlaying ? 'Pause Audio' : 'Play Audio',
      iconSize: 100,  // Adjust the size as needed
    );
  }
}
