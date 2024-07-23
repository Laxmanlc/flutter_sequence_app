import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

class EcommerceItem extends StatefulWidget {
  const EcommerceItem({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EcommerceItemState createState() => _EcommerceItemState();
}

class _EcommerceItemState extends State<EcommerceItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late SequenceAnimation _sequenceAnimation;
  bool _isTapped = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
          animatable: Tween<double>(begin: 1, end: 2),
          from: const Duration(milliseconds: 0),
          to: const Duration(milliseconds: 500),
          tag: "imageScale",
          curve: Curves.easeInOut,
        )
        .addAnimatable(
          animatable: Tween<double>(begin: 0, end: 10),
          from: const Duration(milliseconds: 0),
          to: const Duration(milliseconds: 500),
          tag: "backgroundBlur",
          curve: Curves.easeInOut,
        )
        .addAnimatable(
          animatable: Tween<double>(begin: 0, end: 1),
          from: const Duration(milliseconds: 0),
          to: const Duration(milliseconds: 500),
          tag: "backgroundOpacity",
          curve: Curves.easeIn,
        )
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            _isTapped = !_isTapped;
            _isTapped ? _controller.forward() : _controller.reverse();
          });
        },
        child: Stack(
          children: [
            if (_isTapped)
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Opacity(
                    opacity: _sequenceAnimation["backgroundOpacity"].value,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: _sequenceAnimation["backgroundBlur"].value,
                        sigmaY: _sequenceAnimation["backgroundBlur"].value,
                      ),
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  );
                },
              ),
            Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _sequenceAnimation["imageScale"].value,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(
                          'https://img.freepik.com/premium-vector/tshirt-design-new-tshirt-design-modern-tshirt-design-illustratior_955289-2621.jpg',
                          width: _isTapped ? 300 : 100,
                        ),
                        if (!_isTapped)
                          const Text(
                            'T-Shirt Design',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
