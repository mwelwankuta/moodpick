import "package:moodpick/main.dart";
import "package:supabase_auth_ui/supabase_auth_ui.dart";

Future<void> unlimitedHeart(int post, int postLikes) async {
  // when user has not liked the post
  await supabase.from('posts').update({'likes': postLikes + 1}).eq('id', post);
  print('added ${postLikes + 1}');
}

class LikesService {
  Future<Map<String, dynamic>> toggleLike(
      int post, int postLikes, String user) async {
    final hasLiked = await hasLikedPost(post, user);

    if (hasLiked == true) {
      return {
        'likes': await unlikePost(user, post, postLikes),
        'liked': false,
      };
    }

    return {
      'likes': await likePost(user, post, postLikes),
      'liked': true,
    };
  }

  Future<bool> hasLikedPost(int post, String user) async {
    try {
      var likes = await supabase
          .from('likes')
          .select()
          .eq('post_id', post)
          .eq('creator', user);

      return likes.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<int> likePost(String user, int post, int postLikes) async {
    var newLikes = postLikes + 1;

    await supabase.from('posts').update({'likes': newLikes}).eq('id', post);

    await supabase.from('likes').upsert({
      'post_id': post,
      'creator': user,
      'email': supabase.auth.currentUser?.email,
    });

    return newLikes;
  }

  Future<int> unlikePost(String user, int post, int postLikes) async {
    if (postLikes == 0) return postLikes;

    var newLikes = postLikes - 1;

    await supabase.from('posts').update({'likes': newLikes}).eq('id', post);

    await supabase
        .from('likes')
        .delete()
        .eq('post_id', post)
        .eq('creator', user);

    return newLikes;
  }

// listen to database changes
  Future<RealtimeChannel> listenToLikes(
      int post, Function(int) callback) async {
    return supabase
        .channel('likes:post_id=eq.$post')
        .subscribe((event, payload) {
      print(payload);

      if (event == 'INSERT') {
        callback(1);
      } else {
        callback(-1);
      }
    });
  }
}
