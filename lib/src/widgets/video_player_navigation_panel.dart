import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'duration_view.dart';

class VideoPlayerNavigationPanel extends StatelessWidget {
  const VideoPlayerNavigationPanel({super.key, required this.controller});

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20,
            child: Slider(
              max: controller.value.duration.inMilliseconds.toDouble(),
              value: controller.value.position.inMilliseconds.toDouble(),
              onChanged: ((value) {
                controller.seekTo(Duration(
                  milliseconds: value.toInt(),
                ));
              }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DurationView(
                duration: controller.value.position,
              ),
              DurationView(
                duration: controller.value.duration,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
