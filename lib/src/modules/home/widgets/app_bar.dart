import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moodpick/src/modules/home/widgets/user_modal.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
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
          child: const CircleAvatar(
            radius: 17.0,
            backgroundImage: NetworkImage(
                'https://t3.ftcdn.net/jpg/06/17/13/26/360_F_617132669_YptvM7fIuczaUbYYpMe3VTLimwZwzlWf.jpg'),
            backgroundColor: Colors.transparent,
          ),
        ),
        SvgPicture.asset(
          'assets/logo.svg',
          semanticsLabel: 'App Logo',
          height: 28,
          width: 40,
        ),
      ],
    );
  }
}
