import 'package:flutter/material.dart';

class DurationView extends StatelessWidget {
  const DurationView({super.key, required this.duration});

  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 5,
        left: 5,
        right: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(duration.toString().split(r'.').first),
    );
  }
}
