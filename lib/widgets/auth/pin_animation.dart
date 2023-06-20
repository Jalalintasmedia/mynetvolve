import 'package:flutter/material.dart';

class PinAnimationController {
  late void Function(String) animate;
  late void Function() clear;
}

class PinAnimation extends StatefulWidget {
  final PinAnimationController controller;

  const PinAnimation({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<PinAnimation> createState() => _PinAnimationState(controller);
}

class _PinAnimationState extends State<PinAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<double> _opacityAnimation;
  var _pin = '';

  void animate (String input) {
    _controller.forward();
    setState(() {
      _pin = input;
    });
  }

  void clear () {
    setState(() {
      _pin = '';
    });
  }

  _PinAnimationState(controller) {
    controller.animate = animate;
    controller.clear = clear;
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        _controller.reverse();
      }
      setState(() {});
    });
    _sizeAnimation = Tween<double>(begin: 20, end: 50).animate(_controller);
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      alignment: Alignment.center,
      child: Container(
        height: _sizeAnimation.value,
        width: _sizeAnimation.value,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_sizeAnimation.value / 2),
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          color: _pin=='' ? Colors.transparent : Colors.white,
        ),
        child: Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _sizeAnimation.value / 48,
            // child: Text(
            //   _pin,
            //   style: const TextStyle(
            //     fontWeight: FontWeight.bold,
            //     color: Colors.black45,
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}
