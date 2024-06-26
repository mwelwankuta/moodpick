import 'package:flutter/material.dart';

class FullscreenLoadingIndicator extends StatelessWidget {
  const FullscreenLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.black,
      ),
    );
  }
}
