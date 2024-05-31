import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moodpick/main.dart';
import 'package:uuid/uuid.dart';
import 'package:moodpick/src/modules/home/widgets/upload_modal/pick_image_button.dart';
import 'package:moodpick/src/providers/state.dart';
import 'package:provider/provider.dart';

var uuid = Uuid();

Future<String> uploadImage(file) async {
  final image = File(file);
  var v4 = uuid.v4();

  final imageBytes = image.readAsBytesSync();

  final userId = supabase.auth.currentUser!.id;
  final imagePath = '/$userId/${v4}.${image.path.split('.').last}';

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

class UploadModal extends StatefulWidget {
  const UploadModal({super.key});

  @override
  State<UploadModal> createState() => _UploadModalState();
}

class _UploadModalState extends State<UploadModal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String imgFile = "";
  String? description = "";
  bool _isLoading = false;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<AuthenticationProvider>(context);

    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Colors.white,
      ),
      height: 800,
      // fill height of the screen
      child: SingleChildScrollView(
        child: SizedBox(
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PickImageButton(imgFile, () async {
                    final XFile? img = await picker.pickImage(
                        source: ImageSource.gallery, imageQuality: 70);

                    if (img == null) {
                      return;
                    }

                    setState(() {
                      imgFile = img.path;
                    });
                  }),
                  const SizedBox(height: 20),
                  TextFormField(
                    onSaved: (value) {
                      description = value;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                        surfaceTintColor: Colors.black,
                      ),
                      onPressed: () async {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState!.validate()) {
                          // Process data.
                          setState(() {
                            _isLoading = true;
                          });
                          await createPost(
                              _provider.email, imgFile, description);

                          setState(() {
                            _isLoading = false;
                          });
                          Navigator.of(context).pop();
                        }
                      },
                      child: _isLoading
                          ? Container(
                              width: 24,
                              height: 24,
                              padding: const EdgeInsets.all(2.0),
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            )
                          : const Text('Create'),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
