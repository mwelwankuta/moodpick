import 'package:flutter/material.dart';

class MoodPostWidget extends StatelessWidget {
  // final Mood mood;
  const MoodPostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 4 / 5,
          child: Image.network(
            "https://im.rediff.com/getahead/2023/may/05models3.jpg?w=670&h=900",
            height: 800,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
        ),
        Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_border,
              size: 27,
            ),
            tooltip: 'Like',
          ),
          const Text('100k likes'),
        ]),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
          color: Colors.white,
          child: const Text(
            'doodlewithar “you will need it one day” I’m an artist, only math that I will need is that one from 1st to 3rd grade of elementary, elementaryelementaryelementaryelementaryelementary ',
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
          ),
        )
      ],
    );
  }
}
