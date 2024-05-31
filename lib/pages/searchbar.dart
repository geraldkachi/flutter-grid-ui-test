import 'package:flutter/material.dart';

class SearchComp extends StatelessWidget {
  const SearchComp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), 
            bottomRight: Radius.circular(20)
            ),
          color: Colors.grey,
        ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color(0xFFF4F6FD),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Icon(Icons.search, color: Colors.grey,),
             Icon(Icons.camera_enhance, color: Colors.grey)
          ],
        ),
      ),
    );
  }
}
