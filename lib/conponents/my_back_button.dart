import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
          // borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(12),
        child: Icon(
          Icons.arrow_back_ios,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }
}