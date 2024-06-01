import 'package:flutter/material.dart';

class PostsScreenPlaceHolder extends StatelessWidget {
  const PostsScreenPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "Hooray! you're the first to use moodpick. get startaed by creating a post!",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
