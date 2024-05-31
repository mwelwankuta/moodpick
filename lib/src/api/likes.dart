import "package:moodpick/main.dart";

Future<int> likePost(int post, int postLikes) async {
  var creator = supabase.auth.currentUser!.id;
  var creatorEmail = supabase.auth.currentUser!.email;

  var likes = await supabase.from('likes').select('id').eq('id', post);

  // when user has not liked the post
  if (likes.isEmpty) {
    int likesAfterLike = postLikes + 1;
    // update posts
    await supabase
        .from('posts')
        .update({'likes': likesAfterLike}).eq('id', post);

    // update likes
    await supabase.from('likes').insert({
      'post_id': post,
      'creator': creator,
      'email': creatorEmail,
    });
    return likesAfterLike;
  }

  int likesAfterUnlike = postLikes - 1;
  // update posts
  await supabase
      .from('posts')
      .update({'likes': likesAfterUnlike}).eq('id', post);

  // update likes
  await supabase.from('likes').delete().eq('id', likes[0]['id']);

  return likesAfterUnlike;
}
