import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moodpick/src/providers/state.dart';
import 'package:provider/provider.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
      builder: (context, provider, _) {
        final provider = Provider.of<AuthenticationProvider>(context);

        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
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
                  onSuccess: (Session response) async {
                    var email = response.user.email;

                    if (email == null) {
                      return;
                    }

                    await provider.setAuthenticated(email);

                    Navigator.pushNamed(context, "/home");
                  },
                  showSuccessSnackBar: false,
                  onError: (error) {
                    // Handle error
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
