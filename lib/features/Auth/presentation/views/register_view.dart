import 'package:flutter/material.dart';
import 'package:stylish/features/Auth/presentation/widgets/register_view_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: RegisterViewBody()));
  }
}
