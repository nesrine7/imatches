


import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';
import 'dart:io' as io;

 late VideoPlayerController _controller;
late Future<VideoPlayerController> _futureController;
 bool isClicked = false;

 bool isVisible=true;
getMatchVideoFromSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? match = prefs.getString('video');
  return match;
}



 class _playPauseOverlay extends StatefulWidget {
   const _playPauseOverlay({ Key? key }) : super(key: key);
   
   @override
   __playPauseOverlayState createState() => __playPauseOverlayState();
 }
 
 class __playPauseOverlayState extends State<_playPauseOverlay> {




   @override
   Widget build(BuildContext context) {
     return Stack(
      children: <Widget>[
        Center(child: _controller.value.isInitialized ?AspectRatio(aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
        ) 
        :Container(),
        ),
        Center(
          child: ButtonTheme(
            height: 100.0,
            minWidth: 200.0,
            child: 
            AnimatedOpacity(
          opacity: isClicked ? 0.0 : 1.0,
          duration: Duration(milliseconds: 50),
          child: _controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: ButtonTheme(
                      child: AnimatedOpacity(
                        duration: Duration(microseconds: 10),
                        opacity : isClicked ? 0.0 : 1.0,
                        child:RaisedButton(
                          padding: EdgeInsets.all(60.0),
                          color: Colors.transparent,
                          textColor: Colors.white,
                          onPressed: () {
                            setState(() {
                              isClicked = true;
                              if (_controller.value.isPlaying) {
                              _controller.pause();
                              } else {
                               _controller.play();
                                 }
                            });
                          },
                          child: Icon(
                            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                            size: 120.0,
                          ),
                       ),
                      ),
          ),
        )
                      ),
                    ),
                  ),
                ),
      ]
    );
   }
 }

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {

  getMatchVideoFromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? match = prefs.getString('video');
    return match;
  }


  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/HIGHLIGHTS.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
       SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
  ]);
}

 @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi-Temps 1 ',
      home: Scaffold( 
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller), 
                  _playPauseOverlay(),
                  VideoProgressIndicator(_controller, allowScrubbing: true),
                ],
              ),
                  )
              : Container(),
              
              ), 
                     ),
    );
  }
}