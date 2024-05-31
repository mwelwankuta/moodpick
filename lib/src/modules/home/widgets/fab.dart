import 'package:flutter/material.dart';
import 'package:moodpick/src/modules/home/widgets/upload_modal/upload_modal.dart';

class FloatingActionButtonWidget extends StatefulWidget {
  const FloatingActionButtonWidget({super.key});

  @override
  State<FloatingActionButtonWidget> createState() =>
      _FloatingActionButtonWidgetState();
}

class _FloatingActionButtonWidgetState
    extends State<FloatingActionButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // push the container to the bottom of the screen
      padding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
            width: 50,
            child: Icon(Icons.search),
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return const UploadModal();
                  });
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(235, 235, 235, 100),
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              height: 50,
              width: 50,
              child: const Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }
}
