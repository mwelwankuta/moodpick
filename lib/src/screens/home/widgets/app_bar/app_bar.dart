import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moodpick/src/screens/home/widgets/app_bar/user_modal.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return UserModal();
                  });
            },
            child: const Icon(Icons.settings_outlined),
          ),
          SvgPicture.asset(
            'assets/logo.svg',
            semanticsLabel: 'App Logo',
            height: 28,
            width: 40,
          ),
        ],
      ),
    );
  }
}
