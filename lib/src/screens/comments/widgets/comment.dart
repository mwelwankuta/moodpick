import 'package:flutter/material.dart';
import 'package:moodpick/main.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentWidget extends StatelessWidget {
  String email;
  String comment;
  DateTime createdAt;

  CommentWidget(
      {super.key,
      required this.email,
      required this.comment,
      required this.createdAt});

  @override
  Widget build(BuildContext context) {
    var userEmail = supabase.auth.currentUser!.email;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: email == userEmail
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            email,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            comment,
            maxLines: 3,
          ),
          Text(
            timeago.format(createdAt),
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
