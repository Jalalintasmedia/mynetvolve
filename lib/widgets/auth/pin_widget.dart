import 'package:flutter/material.dart';

import 'pin_animation.dart';

class PinController {
  late void Function(String) addInput;
  late void Function() delete;
  late void Function() notifyWrongInput;
}

class PinWidget extends StatefulWidget {
  final int pinLength;
  final PinController controller;
  final Function(String) onCompleted;

  const PinWidget({
    Key? key,
    required this.pinLength,
    required this.controller,
    required this.onCompleted,
  })  : assert(pinLength <= 8 && pinLength > 0),
        super(key: key);

  @override
  State<PinWidget> createState() => _PinWidgetState(controller);
}

class _PinWidgetState extends State<PinWidget>
    with SingleTickerProviderStateMixin {
  late List<PinAnimationController> _animationControllers;
  late AnimationController _wrongInputAnimationController;
  late Animation<double> _wiggleAnimation;
  String _pin = '';

  _PinWidgetState(PinController controller) {
    controller.addInput = addInput;
    controller.delete = delete;
    controller.notifyWrongInput = notifyWrongInput;
  }

  void addInput(String input) async {
    _pin += input;
    if (_pin.length < widget.pinLength) {
      _animationControllers[_pin.length - 1].animate(input);
    } else if (_pin.length == widget.pinLength) {
      _animationControllers[_pin.length - 1].animate(input);
      await Future.delayed(const Duration(milliseconds: 100));
      widget.onCompleted.call(_pin);
      _pin = '';
    }
  }

  void delete() {
    if (_pin.isNotEmpty) {
      _pin = _pin.substring(0, _pin.length - 1);
      _animationControllers[_pin.length].animate('');
    }
  }

  void notifyWrongInput() {
    _wrongInputAnimationController.forward();
    _animationControllers.forEach((controller) {
      controller.clear();
    });
  }

  @override
  void dispose() {
    _wrongInputAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationControllers = List.generate(widget.pinLength, (index) {
      return PinAnimationController();
    });

    _wrongInputAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _wrongInputAnimationController.reverse();
        }
      });

    _wiggleAnimation = Tween<double>(begin: 0.0, end: 24.0).animate(
      CurvedAnimation(
        parent: _wrongInputAnimationController,
        curve: Curves.elasticIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(_wiggleAnimation.value, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(widget.pinLength, (index) {
          return PinAnimation(
            controller: _animationControllers[index],
          );
        }),
      ),
    );
  }
}
