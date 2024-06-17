import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Column(
          children: [
            Center(
                child: CircularProgressIndicator(),
              ),
            Text("Loading...", style: TextStyle(fontSize: 30, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
