import 'package:flutter/material.dart';
import 'package:moodpick/main.dart';
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
    currentLikes = widget.likes;
    checkLikeStatus();
  }

  @override
  void dispose() {
    isLiked = false;
    currentLikes = 0;
    super.dispose();
  }

  Future<void> checkLikeStatus() async {
    var likeStatus = await likesService.hasLikedPost(widget.id, currentUser!);

    setState(() {
      isLiked = likeStatus;
    });
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
        Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          IconButton(
            onPressed: () async {
              setState(() {
                currentLikes = isLiked ? currentLikes - 1 : currentLikes + 1;
                isLiked = !isLiked;
              });

              await likesService.toggleLike(
                  widget.id, widget.likes, currentUser!);
            },
            icon: Icon(
              isLiked == false ? Icons.favorite_border : Icons.favorite,
              size: 27,
            ),
            tooltip: 'Like',
          ),
          Text('${currentLikes} likes'),
        ]),
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
