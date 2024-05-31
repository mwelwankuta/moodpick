import 'package:flutter/material.dart';
import 'package:moodpick/src/api/posts.dart';
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
  List<Map<String, dynamic>> posts = [];

  @override
  Future<void> initState() async {
    var data = await fetchPosts();
    setState(() {
      print(data);
    });
    super.initState();
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
        floatingActionButton: const FloatingActionButtonWidget(),
        body: RefreshIndicator(
          onRefresh: () async {
            // var posts = await fetchPosts();
          },
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchPosts(),
            initialData: const [],
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty == true) {
                  return const Center(
                    child: Text('No posts yet'),
                  );
                }

                List<Widget> list = [];

                for (var i = snapshot.data!.length - 1; i > 0; i--) {
                  var currentPost = snapshot.data![i];

                  list.add(MoodPostWidget(
                    id: currentPost['id'],
                    creator: currentPost['creator'],
                    description: currentPost['description'],
                    likes: currentPost['likes'],
                    imageUrl: currentPost['image'],
                  ));
                }

                return PageView(
                  controller: controller,
                  scrollDirection: Axis.vertical,
                  children: list,
                );

                // has data
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              ));
            },
          ),
        ),
      );
    });
  }
}
