import 'dart:io';
import 'package:moodpick/main.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

Future<String> uploadImage(file) async {
  final image = File(file);
  var v4 = uuid.v4();

  final imageBytes = image.readAsBytesSync();

  final userId = supabase.auth.currentUser!.id;
  final imagePath = '/$userId/${v4}.${image.path.split('.').last}';
  print(imagePath);

  await supabase.storage.from("photos").uploadBinary(imagePath, imageBytes);

  final imageUrl = supabase.storage.from("photos").getPublicUrl(imagePath);
  return imageUrl;
}

Future<void> createPost(
  creator,
  image,
  description,
) async {
  final imageUrl = await uploadImage(image);
  await supabase.from('posts').insert({
    'creator': creator,
    'image': imageUrl,
    'description': description,
    'likes': 0
  });
}

Future<List<Map<String, dynamic>>> fetchPosts() async {
  return await supabase.from('posts').select('*');
}
