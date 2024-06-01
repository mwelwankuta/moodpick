import 'package:flutter/material.dart';
import 'package:moodpick/src/modules/comments/comment.dart';
import 'package:moodpick/src/services/comments.dart';

class CommentsScreen extends StatefulWidget {
  int postId;
  CommentsScreen({super.key, required this.postId});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  List<CommentWidget> comments = [];
  var commentsService = CommentsService();

  @override
  void initState() {
    getComments();
    super.initState();
  }

  Future<void> getComments() async {
    var postComments = await commentsService.getCommentsForPost(widget.postId);

    setState(() {
      for (var comment in postComments) {
        comments.add(
          CommentWidget(comment: comment.comment, email: comment.creator),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Comments'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: comments,
          ),
        ));
  }
}
