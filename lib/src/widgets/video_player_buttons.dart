import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerButtons extends StatelessWidget {
  const VideoPlayerButtons({super.key, required this.controller});

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                controller.seekTo(
                  controller.value.position -
                      const Duration(
                        seconds: 10,
                      ),
                );
              },
              icon: const Icon(Icons.replay_10),
            ),
            IconButton(
              onPressed: () {
                controller.value.isPlaying
                    ? controller.pause()
                    : controller.play();
              },
              icon: Icon(
                controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
            IconButton(
              onPressed: () {
                controller.seekTo(
                  controller.value.position +
                      const Duration(
                        seconds: 10,
                      ),
                );
              },
              icon: const Icon(Icons.forward_10),
            ),
          ],
        ),
      ),
    );
  }
}
