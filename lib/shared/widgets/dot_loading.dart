import 'package:flutter/material.dart';

class DotsLoading extends StatefulWidget {
  const DotsLoading({super.key});

  @override
  State<DotsLoading> createState() => _DotsLoadingState();
}

class _DotsLoadingState extends State<DotsLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: const Duration(milliseconds: 600))
      ..addListener(() {
        if (_controller.status == AnimationStatus.completed) {
          _controller.reset();
          setState(() {
            activeIndex = (activeIndex + 1) % 3; // chạy qua 3 chấm
          });
          _controller.forward();
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDot(int index) {
    bool isActive = index == activeIndex;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 6.5),
      width: 13,
      height: 13,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue.shade800 : Colors.blue.shade300,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, _buildDot),
    );
  }
}
