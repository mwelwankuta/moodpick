class CommentModel {
  final int id;
  final String postId;
  final String creator;
  final String email;
  final String comment;
  final DateTime createdAt;

  CommentModel({
    required this.id,
    required this.postId,
    required this.creator,
    required this.comment,
    required this.createdAt,
    required this.email,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) throw Exception("No data found in the json object");

    return CommentModel(
      id: json['id'],
      postId: json['post_id'],
      creator: json['creator'],
      comment: json['comment'],
      createdAt: DateTime.parse(json['created_at']),
      email: json['email'],
    );
  }
}
