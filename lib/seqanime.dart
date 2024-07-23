import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:sequenceanime/realtimeuse.dart';

// ignore: use_key_in_widget_constructors
class OnboardingScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late SequenceAnimation _sequenceAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
          animatable: Tween<double>(begin: 0, end: 1),
          from: const Duration(seconds: 0),
          to: const Duration(seconds: 1),
          tag: "textOpacity",
          curve: Curves.easeIn,
        )
        .addAnimatable(
          animatable: Tween<double>(begin: 1, end: 1.1),
          from: const Duration(seconds: 1),
          to: const Duration(seconds: 1),
          tag: "textScale",
          curve: Curves.easeOut,
        )
        .addAnimatable(
          animatable: Tween<Offset>(
              begin: const Offset(-1, 0), end: const Offset(0, 0)),
          from: const Duration(seconds: 1),
          to: const Duration(seconds: 2),
          tag: "imageSlide",
          curve: Curves.easeInOut,
        )
        .addAnimatable(
          animatable: Tween<double>(begin: 0, end: 1),
          from: const Duration(seconds: 1),
          to: const Duration(seconds: 2),
          tag: "imageOpacity",
          curve: Curves.easeIn,
        )
        .addAnimatable(
          animatable: Tween<double>(begin: 0, end: 1),
          from: const Duration(seconds: 2),
          to: const Duration(seconds: 3),
          tag: "buttonOpacity",
          curve: Curves.easeIn,
        )
        .addAnimatable(
          animatable: Tween<double>(begin: 1, end: 1.1),
          from: const Duration(seconds: 3),
          to: const Duration(seconds: 3),
          tag: "buttonScale",
          curve: Curves.easeOut,
        )
        .animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(
                  opacity: _sequenceAnimation["textOpacity"].value,
                  child: Transform.scale(
                    scale: _sequenceAnimation["textScale"].value,
                    child: const Text(
                      "Welcome to Our App",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Opacity(
                  opacity: _sequenceAnimation["imageOpacity"].value,
                  child: SlideTransition(
                    position:
                        _sequenceAnimation["imageSlide"] as Animation<Offset>,
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQffJi11zN4P0-LBWUBf_uLwphUJxLGcV_oaQ&s',
                      width: 200,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Opacity(
                  opacity: _sequenceAnimation["buttonOpacity"].value,
                  child: Transform.scale(
                    scale: _sequenceAnimation["buttonScale"].value,
                    child: ElevatedButton(
                      onPressed: () {
                        print('Button pressed');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EcommerceItem()),
                        );
                      },
                      child: const Text("Get Started"),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
