import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moodpick/src/modules/home/widgets/pick_image_button.dart';
import 'package:moodpick/src/providers/state.dart';
import 'package:provider/provider.dart';

class UploadModal extends StatefulWidget {
  const UploadModal({super.key});

  @override
  State<UploadModal> createState() => _UploadModalState();
}

class _UploadModalState extends State<UploadModal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthenticationProvider>(context);

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
                  PickImageButton(() async {
                    final avatarFile = File('path/to/file');
                  }),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Caption'),
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
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState!.validate()) {
                          // Process data.
                        }
                      },
                      child: const Text('Create'),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
