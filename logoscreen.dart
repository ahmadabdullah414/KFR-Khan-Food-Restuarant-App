import 'package:flutter/material.dart';
import 'package:kfr/login.dart';
import 'package:video_player/video_player.dart';
import 'package:kfr/menu.dart'; // Assuming MenuPage is your main screen


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the video player controller with the MP4 video
    _controller = VideoPlayerController.asset('assets/T.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
      })
      ..setLooping(false)
      ..play(); // Play the video automatically

    // Navigate to the main page when the video ends
    _controller.addListener(() {
      if (!_controller.value.isPlaying && _controller.value.position == _controller.value.duration) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()), // Navigate to main page
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _controller.value.isInitialized
          ? Center(
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
