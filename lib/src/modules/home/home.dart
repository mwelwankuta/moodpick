import 'package:flutter/material.dart';
import 'package:moodpick/src/modules/home/widgets/app_bar.dart';
import 'package:moodpick/src/modules/home/widgets/fab.dart';
import 'package:moodpick/src/modules/home/widgets/mood_post.dart';
import 'package:moodpick/src/providers/state.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: 0);

    return Consumer<AuthenticationProvider>(builder: (context, provider, _) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(100.0),
              child: SafeArea(
                  minimum: EdgeInsets.fromLTRB(15, 40, 15, 0),
                  child: AppBarWidget())),
          body: PageView(
            controller: controller,
            scrollDirection: Axis.vertical,
            children: const [
              MoodPostWidget(),
              MoodPostWidget(),
              MoodPostWidget(),
              MoodPostWidget(),
              MoodPostWidget(),
              MoodPostWidget(),
            ],
          ),
          floatingActionButton: const FloatingActionButtonWidget());
    });
  }
}
