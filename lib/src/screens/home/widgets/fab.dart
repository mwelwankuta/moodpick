import 'package:flutter/material.dart';
import 'package:moodpick/src/screens/home/widgets/upload_modal/upload_modal.dart';

class FloatingActionButtonWidget extends StatefulWidget {
  void Function() onPostUpload;
  FloatingActionButtonWidget({super.key, required this.onPostUpload});

  @override
  State<FloatingActionButtonWidget> createState() =>
      _FloatingActionButtonWidgetState();
}

class _FloatingActionButtonWidgetState
    extends State<FloatingActionButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return UploadModal(widget.onPostUpload);
                });
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(235, 235, 235, 100),
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            child: Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(235, 235, 235, 100),
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  height: 50,
                  width: 50,
                  child: const Icon(Icons.add),
                ),
                const SizedBox(width: 10),
                const Text("Post", style: TextStyle()),
              ],
            ),
          ),
        )
      ],
    );
  }
}