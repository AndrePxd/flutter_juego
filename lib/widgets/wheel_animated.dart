import 'package:flutter/material.dart';

class AnimatedNumberWheel extends StatefulWidget {
  final int number;

  const AnimatedNumberWheel({required this.number});

  @override
  _AnimatedNumberWheelState createState() => _AnimatedNumberWheelState();
}

class _AnimatedNumberWheelState extends State<AnimatedNumberWheel>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int _currentNumber = 0;

  @override
  void initState() {
    super.initState();
    _currentNumber = widget.number;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_animationController);
  }

  @override
  void didUpdateWidget(AnimatedNumberWheel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.number != _currentNumber) {
      _animateToNumber(widget.number);
    }
  }

  void _animateToNumber(int number) {
    _animationController.reset();
    _animationController.forward().then((value) {
      setState(() {
        _currentNumber = number;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.brown[300],
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: RotationTransition(
          turns: _animation,
          child: Text(
            _currentNumber.toString(),
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}