import 'package:flutter/material.dart';
import 'package:shop_app/core/provider/auth_provider.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm(
      {super.key,
      required this.email,
      required this.password,
      required this.confirmPassword});
  final String email;
  final String password;
  final String confirmPassword;

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? firstName;
  String? lastName;

  AuthProvider authProvider = AuthProvider();

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            onSaved: (newValue) => firstName = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kNamelNullError);
              }
              firstName = value;
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kNamelNullError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "First Name",
              hintText: "Enter your first name",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            onSaved: (newValue) => lastName = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kNamelNullError);
              }
              lastName = value;
              return;
            },
            decoration: const InputDecoration(
              labelText: "Last Name",
              hintText: "Enter your last name",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
            ),
          ),
          const SizedBox(height: 20),
          FormError(errors: errors),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                authProvider.register(
                  email: widget.email,
                  password: widget.password,
                  firstName: firstName,
                  lastName: lastName,
                );
              }
            },
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }
}
