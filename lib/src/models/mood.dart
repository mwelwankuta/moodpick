class MoodModel {
  final String id;
  final String imageUrl;
  final String feeling;
  final String userId;
  final String userImage;
  final String email;

  MoodModel({
    required this.imageUrl,
    required this.feeling,
    required this.userId,
    required this.userImage,
    required this.id,
    required this.email,
  });

  fromJson(Map<String, dynamic> json) {
    return MoodModel(
      id: json['id'],
      imageUrl: json['image'],
      feeling: json['feeling'],
      userId: json['userId'],
      userImage: json['userImage'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': imageUrl,
      'feeling': feeling,
      'userId': userId,
      'userImage': userImage,
    };
  }
}
