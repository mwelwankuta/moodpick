import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moodpick/src/modules/home/widgets/mood_post.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: 0);

    return PageView(
      controller: controller,
      scrollDirection: Axis.vertical,
      children: const [
        MoodPostWidget(),
      ],
    );
  }
}
