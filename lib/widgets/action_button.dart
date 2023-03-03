import 'package:flutter/material.dart';


class ActionButton extends StatelessWidget {
  const ActionButton({Key? key, this.onPressed, required this.icon}) : super(key: key);
  final VoidCallback? onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape:  const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: Colors.purpleAccent.shade100,
      elevation: 4.0,
        child: IconButton(
            onPressed:  onPressed,
            icon: icon,
      ),

    );
  }
}
