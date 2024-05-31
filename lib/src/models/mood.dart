class MoodModel {
  final int id;
  final String image;
  final String description;
  final String creator;
  final int likes;

  MoodModel({
    required this.image,
    required this.description,
    required this.creator,
    required this.id,
    required this.likes,
  });

  factory MoodModel.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) throw Exception("No data found in the json object");

    return MoodModel(
        image: json['image'],
        description: json['description'],
        creator: json['creator'],
        id: json['id'],
        likes: json['likes']);
  }
}
