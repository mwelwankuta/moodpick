import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moodpick/main.dart';
import 'package:moodpick/src/screens/comments/comments_screen.dart';
import 'package:moodpick/src/services/likes.dart';

class MoodPostWidget extends StatefulWidget {
  final int id;
  final String creator;
  final String description;
  final int likes;
  final String imageUrl;

  const MoodPostWidget({
    super.key,
    required this.id,
    required this.creator,
    required this.description,
    required this.likes,
    required this.imageUrl,
  });

  @override
  State<MoodPostWidget> createState() => _MoodPostWidgetState();
}

class _MoodPostWidgetState extends State<MoodPostWidget> {
  var likesService = LikesService();
  var currentUser = supabase.auth.currentUser?.id;

  int currentLikes = 0;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();

    if (mounted) {
      setState(() {
        currentLikes = widget.likes;
      });
    }

    checkLikeStatus();
  }

  Future<void> checkLikeStatus() async {
    var likeStatus = await likesService.hasLikedPost(widget.id, currentUser!);

    if (mounted) {
      setState(() {
        isLiked = likeStatus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.creator,
            style: const TextStyle(fontWeight: FontWeight.w100),
          ),
        ),
        AspectRatio(
          aspectRatio: 4 / 5,
          child: Image.network(
            widget.imageUrl,
            height: 800,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Row(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    setState(() {
                      currentLikes = isLiked
                          ? (currentLikes > 0 ? currentLikes - 1 : 0)
                          : currentLikes + 1;
                      isLiked = !isLiked;
                    });

                    var likeStatus = await likesService.toggleLike(
                        widget.id, widget.likes, currentUser!);
                    setState(() {
                      isLiked = likeStatus['liked'];
                      currentLikes = likeStatus['likes'];
                    });
                  },
                  icon: Icon(
                    isLiked == false ? Icons.favorite_border : Icons.favorite,
                    size: 27,
                    color: isLiked == false ? Colors.black : Colors.red,
                  ),
                  tooltip: 'Like',
                ),
                Text('${currentLikes} likes'),
              ],
            ),
            IconButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CommentsScreen(postId: widget.id)));
              },
              icon: SvgPicture.asset(
                "assets/comment_icon.svg",
                height: 27,
                width: 27,
              ),
              tooltip: 'comments',
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
          color: Colors.white,
          child: Text(
            widget.description,
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
          ),
        )
      ],
    );
  }
}
