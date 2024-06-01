import 'package:flutter/material.dart';
import 'package:moodpick/src/models/comment.dart';
import 'package:moodpick/src/screens/comments/widgets/comment.dart';
import 'package:moodpick/src/screens/comments/widgets/comments_placeholder.dart';
import 'package:moodpick/src/widgets/fullscreen_loading_indicator.dart';
import 'package:moodpick/src/services/comments.dart';

class CommentsScreen extends StatefulWidget {
  final int postId;

  CommentsScreen({super.key, required this.postId});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final CommentsService commentsService = CommentsService();
  final TextEditingController inputController = TextEditingController();

  List<CommentModel> comments = [];
  bool isLoading = true;
  bool isAdding = false;

  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  Future<void> fetchComments() async {
    final postComments =
        await commentsService.getCommentsForPost(widget.postId);

    if (!mounted) return;

    setState(() {
      comments = postComments.reversed
          .map((commentJson) => CommentModel.fromJson(commentJson))
          .toList();
      isLoading = false;
    });
  }

  Future<void> addComment() async {
    if (inputController.text.isEmpty) return;

    setState(() => isAdding = true);

    await commentsService.addComment(widget.postId, inputController.text);
    inputController.clear();

    setState(() => isAdding = false);
    await fetchComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Comments"),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          if (isLoading)
            const FullscreenLoadingIndicator()
          else if (comments.isEmpty)
            const CommentsPlaceholder()
          else
            Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];

                  return CommentWidget(
                    comment: comment.comment,
                    email: comment.email,
                    createdAt: comment.createdAt,
                  );
                },
              ),
            ),
          _buildCommentInput(),
        ],
      ),
    );
  }

  Widget _buildCommentInput() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white70,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: inputController,
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
              onPressed: isAdding ? null : addComment,
              icon: isAdding
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.send),
            ),
          ),
        ],
      ),
    );
  }
}
