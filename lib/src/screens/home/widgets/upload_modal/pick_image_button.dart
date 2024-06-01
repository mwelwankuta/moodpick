import 'dart:io';

import 'package:flutter/material.dart';

typedef MyCallback = Future<void> Function();

class PickImageButton extends StatelessWidget {
  final String? img;
  final MyCallback pickImage;

  const PickImageButton(this.img, this.pickImage, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pickImage();
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        decoration: const BoxDecoration(
            color: Color.fromRGBO(243, 243, 243, 0.612),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // Image Icon with Background
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(235, 235, 235, 100),
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  height: 50,
                  width: 50,
                  child: const Icon(Icons.image),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  'Pick Image',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              child: img != ""
                  ? CircleAvatar(
                      radius: 20.0,
                      backgroundImage: FileImage(File(img!)),
                      backgroundColor: Colors.black,
                    )
                  : const Text("..."),
            )
          ],
        ),
      ),
    );
  }
}
