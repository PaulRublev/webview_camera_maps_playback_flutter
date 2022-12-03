import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'video_player_buttons.dart';
import 'video_player_navigation_panel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;
  bool _isControlVisible = true;
  final String _url =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(_url)
      ..initialize().then((value) {
        setState(() {});
      });
    _controller
      ..addListener(() {
        setState(() {});
      })
      ..play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_url.split(r'/').last),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isControlVisible = !_isControlVisible;
                      });
                    },
                    child: Stack(
                      children: [
                        VideoPlayer(_controller),
                        _isControlVisible
                            ? VideoPlayerButtons(controller: _controller)
                            : const SizedBox(),
                        _isControlVisible
                            ? VideoPlayerNavigationPanel(
                                controller: _controller)
                            : const SizedBox(),
                      ],
                    ),
                  ),
                )
              : Container(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
