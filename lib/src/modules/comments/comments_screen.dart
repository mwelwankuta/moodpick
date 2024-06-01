import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moodpick/src/modules/comments/widgets/comment.dart';
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
        backgroundColor: Colors.white,
        // custom app bar
        appBar: AppBar(
          title: const Text("Comments"),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: comments,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.white70,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Add a comment',
                        focusColor: Colors.deepOrangeAccent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white70,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.send),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
