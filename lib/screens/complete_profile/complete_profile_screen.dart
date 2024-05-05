import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/complete_profile_form.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/complete_profile";

  const CompleteProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as CompleteProfileArguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text("Complete Profile", style: headingStyle),
                  const Text(
                    "Complete your details or continue  \nwith social media",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  CompleteProfileForm(
                    email: args.email,
                    password: args.password,
                    confirmPassword: args.confirmPassword,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "By continuing your confirm that you agree \nwith our Term and Condition",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CompleteProfileArguments {
  final String email;
  final String password;
  final String confirmPassword;

  CompleteProfileArguments(this.email, this.password, this.confirmPassword);
}
