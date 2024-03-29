import 'dart:async';
import 'package:app1/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    // Create the VideoPlayerController instance
    _controller = VideoPlayerController.asset('assets/splash.mp4');

    // Initialize the video player
    _initializeVideo();
  }

  void _initializeVideo() async {
    if (_controller.value.isInitialized) {
      print("initialized");
      if (!_controller.value.isPlaying) {
        print("not playing");
        _controller.setLooping(false);
        _controller.setVolume(0.5);
        setState(() {
          _visible = true;
        });

        // Play the video
        await Future.delayed(Duration(seconds: 2), () {
          _controller.play();
          /* Timer.periodic(Duration(milliseconds: 1000), (timer) {
            if(_controller.value.isCompleted)
              timer.cancel();
            setState(() {\
            });
          });*/
        });
        _initializeVideo();
      } else {
        print("Playing");
        _controller.addListener(_onVideoCompleted);
      }
    } else {
      print("not initialized");
      await _controller.initialize().then((value) => _initializeVideo());
    }
  }

  void _onVideoCompleted() {
    // Wait for the video to complete
    Future.delayed(Duration(seconds: 2), () {
      if (_controller.value.isCompleted) {
        // Pause the video
        _controller.pause();
        // Hide the video
        setState(() {
          _visible = false;
        });
        // Navigate to the next page
        Future.delayed(Duration(seconds: 2), () {
          navigationPage();
          // Dispose the VideoPlayerController instance to avoid conflicts with hot reload
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    // Dispose the VideoPlayerController instance when the widget is disposed
    _controller.dispose();
  }

  _getVideoBackground() {
    return AnimatedOpacity(
      opacity: _visible ? 0.8 : 0.0,
      duration: Duration(milliseconds: (300)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }

  void navigationPage() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (Route<dynamic> route) => false,
    );
    this.dispose();
  }

  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (_controller.value.isPlaying) {
            _controller.pause();
            navigationPage();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Color.fromRGBO(71, 89, 110, 1),
              body: Stack(
                children: <Widget>[
                  //SizedBox(height: MediaQuery.of(context).size.height / 8),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          alignment: Alignment.center,
                          child: _getVideoBackground(),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height / 10,
                    right: MediaQuery.of(context).size.width / 3.4,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(color: Colors.white70),
                              children: [
                                TextSpan(text: 'Made by:\n'),
                                TextSpan(
                                  text:
                                      'Abdallah Sankari\nMaxime Boyer\nAnais Ulloa\nKiyoshi Frade Araki\nMauricio Orenbuch Hendel',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

/*
  _getBackgroundColor() {
    return Container(color: Colors.transparent //.withAlpha(120),
    );
  }*/

/* _getContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
    );
  }*/
