import 'package:flutter/material.dart';
import 'package:moodpick/main.dart';

Future<int> likePost(int post, int postLikes) async {
  var creator = supabase.auth.currentUser!.id;
  var creatorEmail = supabase.auth.currentUser!.email;

  var likes = await supabase
      .from('likes')
      .select('creator, email')
      .eq('id', post)
      .eq('creator', creator);

  // when user has not liked the post
  if (likes.isEmpty) {
    postLikes += 1;
    // update posts
    await supabase.from('posts').update({'likes': postLikes}).eq('id', post);

    // update likes
    await supabase.from('likes').insert({
      'post_id': post,
      'creator': creator,
      'email': creatorEmail,
    });
    return postLikes;
  }

  postLikes -= 1;
  // update posts
  await supabase.from('posts').update({'likes': postLikes}).eq('id', post);

  // update likes
  await supabase.from('likes').delete().eq('id', likes[0]['id']);

  return postLikes;
}

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
