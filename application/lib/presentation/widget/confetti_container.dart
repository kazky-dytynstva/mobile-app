import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiContainer extends StatelessWidget {
  final ConfettiController controller;

  /// The [blastDirection] is a radial value to determine the direction of the
  /// particle emission.
  final double blastDirection;
  final int numberOfParticles;

  const ConfettiContainer({
    required this.controller,
    required this.blastDirection,
    this.numberOfParticles = 10,
    super.key,
  });

  final _confettiColors = const [
    Colors.green,
    Colors.blue,
    Colors.pink,
    Colors.orange,
    Colors.deepPurpleAccent,
  ];

  @override
  Widget build(BuildContext context) => ConfettiWidget(
        confettiController: controller,
        blastDirection: blastDirection,
        particleDrag: 0.05,
        emissionFrequency: 0.05,
        numberOfParticles: numberOfParticles,
        colors: _confettiColors,
        strokeWidth: 0,
        gravity: 0.05,
        minimumSize: const Size(10, 5),
        maximumSize: const Size(20, 5),
      );
}
