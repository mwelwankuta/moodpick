import 'package:flutter/material.dart';
import 'package:moodpick/src/api/likes.dart';

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
  @override
  Widget build(BuildContext context) {
    int currentLikes = widget.likes;

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
              int newLikes = await likePost(widget.id, currentLikes);
              setState(() {
                currentLikes = newLikes;
              });
            },
            icon: const Icon(
              Icons.favorite_border,
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
