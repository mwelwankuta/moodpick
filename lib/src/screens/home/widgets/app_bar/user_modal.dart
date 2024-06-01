import 'package:flutter/material.dart';
import 'package:moodpick/main.dart';
import 'package:moodpick/src/providers/state.dart';
import 'package:provider/provider.dart';

class UserModal extends StatelessWidget {
  const UserModal({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthenticationProvider>(context);

    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Colors.white,
      ),
      height: 200,
      child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                provider.email,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  await provider.logOut();
                  await supabase.auth.signOut();

                  Navigator.popAndPushNamed(context, "/landing");
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    color: Colors.grey[200],
                  ),
                  child: const Center(
                    child: Center(
                      child: Text("Logout"),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
