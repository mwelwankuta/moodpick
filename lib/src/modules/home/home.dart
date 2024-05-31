import 'package:flutter/material.dart';
import 'package:moodpick/main.dart';
import 'package:moodpick/src/modules/home/widgets/app_bar/app_bar.dart';
import 'package:moodpick/src/modules/home/widgets/fab.dart';
import 'package:moodpick/src/modules/home/widgets/post_card.dart';
import 'package:moodpick/src/providers/state.dart';
import 'package:provider/provider.dart';

Future<List<Map<String, dynamic>>> fetchPosts() async {
  final data = await supabase.from('posts').select('*');

  return data;
}

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
          body: FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchPosts(),
            initialData: const [],
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data!.isEmpty);

                if (snapshot.data!.isEmpty == true) {
                  return const Center(
                    child: Text('No posts yet'),
                  );
                }

                List<Widget> list = [];

                for (var i = 0; i < snapshot.data!.length; i++) {
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
          floatingActionButton: const FloatingActionButtonWidget());
    });
  }
}
