import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_form/bloc/auth_bloc.dart';
import 'package:login_form/home_screen.dart';
import 'package:login_form/widgets/gradient_button.dart';
import 'package:login_form/widgets/login_field.dart';
import 'package:login_form/widgets/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, authState) {
          if (authState is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  authState.error,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }
          if (authState is AuthSuccess) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
                (route) => false);
          }
        },
        builder: (context, authState) {
          if (authState is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Image.asset('assets/images/signin_balls.png'),
                  const Text(
                    'Sign in.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                  const SizedBox(height: 50),
                  const SocialButton(
                      iconPath: 'assets/svgs/g_logo.svg',
                      label: 'Continue with Google'),
                  const SizedBox(height: 20),
                  const SocialButton(
                    iconPath: 'assets/svgs/f_logo.svg',
                    label: 'Continue with Facebook',
                    horizontalPadding: 90,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'or',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 15),
                  LoginField(
                    hintText: 'Email',
                    controller: emailController,
                  ),
                  const SizedBox(height: 15),
                  LoginField(
                    hintText: 'Password',
                    controller: passwordController,
                  ),
                  const SizedBox(height: 20),
                  GradientButton(
                    buttonText: "Sign in",
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthLoginRequested(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          ));
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
