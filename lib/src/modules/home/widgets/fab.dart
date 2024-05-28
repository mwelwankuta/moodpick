import 'package:flutter/material.dart';

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
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 40, 20),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(243, 243, 243, 0.612),
                borderRadius: BorderRadius.all(Radius.circular(40))),
            child: Row(
              children: [
                // Persons Icon with Background
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(235, 235, 235, 100),
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  height: 50,
                  width: 50,
                  child: const Icon(Icons.people),
                ),

                const SizedBox(
                  width: 8,
                ),

                const Text(
                  'Add Friends',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w100),
                )
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(235, 235, 235, 100),
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            height: 50,
            width: 50,
            child: const Icon(Icons.camera_alt_outlined),
          ),
        ],
      ),
    );
  }
}
