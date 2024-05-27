class Mood {
  final String id;
  final String imageUrl;
  final String feeling;
  final String authorId;
  final String authorImage;

  Mood({
    required this.imageUrl,
    required this.feeling,
    required this.authorId,
    required this.authorImage,
    required this.id, required String authorName,
  });
}

