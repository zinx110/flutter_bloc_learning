import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:login_form/bloc/auth_bloc.dart";
import "package:login_form/login_screen.dart";
import "package:login_form/widgets/gradient_button.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is! AuthSuccess) {
            return const Text("");
          }
          return Column(
            children: [
              Center(
                child: Text((state).uid),
              ),
              const SizedBox(height: 20),
              GradientButton(
                buttonText: "Sign Out",
                onPressed: () {
                  context.read<AuthBloc>().add(AuthLogoutRequested());
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
