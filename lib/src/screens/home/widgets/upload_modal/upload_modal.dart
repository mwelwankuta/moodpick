import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moodpick/src/services/posts.dart';
import 'package:moodpick/src/screens/home/widgets/upload_modal/pick_image_button.dart';
import 'package:moodpick/src/providers/state.dart';
import 'package:provider/provider.dart';

class UploadModal extends StatefulWidget {
  final Function() onPostUpload;
  const UploadModal(this.onPostUpload, {super.key});

  @override
  State<UploadModal> createState() => _UploadModalState();
}

class _UploadModalState extends State<UploadModal> {
  String imgFile = "";
  bool _isLoading = false;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<AuthenticationProvider>(context);
    final TextEditingController captionController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Colors.white,
      ),
      height: 700,
      child: SingleChildScrollView(
        child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PickImageButton(imgFile, () async {
                  final XFile? img = await picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 85,
                  );

                  if (img == null) {
                    return;
                  }

                  setState(() {
                    imgFile = img.path;
                  });
                }),
                const SizedBox(height: 20),
                TextField(
                  controller: captionController,
                  decoration: const InputDecoration(
                      labelText: 'Caption..',
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        _isLoading = true;
                      });

                      await createPost(
                          _provider.email, imgFile, captionController.text);

                      widget.onPostUpload();
                      setState(() {
                        _isLoading = false;
                      });

                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 168, 168, 168),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
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
                          : const Text(
                              'Create',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
