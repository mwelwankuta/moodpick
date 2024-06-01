import 'package:moodpick/main.dart';
import 'package:moodpick/src/models/comment.dart';

class CommentsService {
  Future<List<CommentModel>> getCommentsForPost(int postId) async {
    try {
      var comments = await supabase
          .from('comments')
          .select()
          .eq('post_id', postId)
          .order('created_at', ascending: false);

      return comments.map((comment) => CommentModel.fromJson(comment)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> addComment(int postId, String comment) async {
    await supabase.from('comments').upsert({
      'post_id': postId,
      'comment': comment,
      'creator': supabase.auth.currentUser?.id,
      'email': supabase.auth.currentUser?.email,
    });
  }

  Future<void> deleteComment(int commentId) async {
    await supabase.from('comments').delete().eq('id', commentId);
  }

  // listen to new comments
  void listenToComments(int postId) {
    supabase.channel('comments:post_id=$postId').subscribe((event, payload) {
      print('New comment: ${payload}');
    });
  }
}
