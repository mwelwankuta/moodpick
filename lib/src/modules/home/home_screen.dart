import 'package:flutter/material.dart';
import 'package:moodpick/src/services/posts.dart';
import 'package:moodpick/src/models/mood.dart';
import 'package:moodpick/src/modules/home/widgets/app_bar/app_bar.dart';
import 'package:moodpick/src/modules/home/widgets/fab.dart';
import 'package:moodpick/src/modules/home/widgets/post_card.dart';
import 'package:moodpick/src/providers/state.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MoodModel> posts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    homeScreenPosts();
  }

  homeScreenPosts() async {
    var fetchedPosts = await fetchPosts();

    setState(() {
      if (!mounted) return;

      posts = [];

      for (var i = fetchedPosts.length - 1; i > 0; i--) {
        var post = fetchedPosts[i];
        posts.add(MoodModel.fromJson(post));
      }
      isLoading = false;
    });
  }

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
        floatingActionButton: FloatingActionButtonWidget(
          onPostUpload: () {
            print('called from other page');
            homeScreenPosts();
          },
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              await homeScreenPosts();
            },
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                : posts.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Hooray! you're the first to use moodpick. get startaed by creating a post!",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : PageView(
                        controller: controller,
                        scrollDirection: Axis.vertical,
                        children: posts.map((post) {
                          return MoodPostWidget(
                            creator: post.creator,
                            description: post.description,
                            imageUrl: post.image,
                            id: post.id,
                            likes: post.likes,
                          );
                        }).toList(),
                      )),
      );
    });
  }
}