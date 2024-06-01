import 'package:flutter/material.dart';

class CommentsPlaceholder extends StatelessWidget {
  const CommentsPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "Hooray! you're the first to comment on this post.",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
