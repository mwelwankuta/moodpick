import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommentWidget extends StatelessWidget {
  String email;
  String comment;

  CommentWidget({super.key, required this.email, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          email,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          comment,
          maxLines: 3,
        ),
      ],
    );
  }
}
