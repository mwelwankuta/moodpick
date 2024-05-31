import "package:moodpick/main.dart";

void unlimitedHeart(int post, int postLikes) async {
  // when user has not liked the post
  await supabase.from('posts').update({'likes': postLikes + 1}).eq('id', post);
}
