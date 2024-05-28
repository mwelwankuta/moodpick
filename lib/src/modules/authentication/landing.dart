import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/logo.svg",
                  height: 40,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "know how your friends are feeling",
                  style: TextStyle(
                      fontWeight: FontWeight.w100, fontFamily: 'Inter'),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 70,
          ),

          // Login Button
          InkWell(
            onTap: () {
              // TODO: login with google
            },
            child: SizedBox(
              width: double.infinity,
              child: Container(
                padding: const EdgeInsets.fromLTRB(30, 13, 30, 13),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: const Color(0xFCFCFCFF),
                  border: Border.all(
                    color: const Color(0xDDDDDDDD),
                    width: 1.0,
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Login with Google",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
