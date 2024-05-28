import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

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
          SupaSocialsAuth(
            socialProviders: const [
              OAuthProvider.google,
            ],
            colored: true,
            redirectUrl:
                'https://qaytoeaupdapzuyuzark.supabase.co/auth/v1/callback',
            onSuccess: (Session response) {
              print(response.user.email);
            },
            onError: (error) {},
          )
        ],
      ),
    );
  }
}
