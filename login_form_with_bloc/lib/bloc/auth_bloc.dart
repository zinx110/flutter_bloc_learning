import "package:flutter/foundation.dart";
import "package:flutter_bloc/flutter_bloc.dart";
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);

    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    // print("Auth Bloc - $change");
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
    // print("Auth Transition Bloc - $transition");
  }

  void _onLoginRequested(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final email = event.email;
      final password = event.password;

      if (password.length < 6) {
        emit(AuthFailure("Password must be at least 6 characters"));
        return;
      }
      if (password.isEmpty) {
        emit(AuthFailure("Password must be at least 6 characters"));
        return;
      }

      await Future.delayed(const Duration(seconds: 5), () {
        return emit(AuthSuccess(uid: '$email-$password'));
      });
    } catch (e) {
      return emit(AuthFailure(e.toString()));
    }
  }

  void _onLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 2), () {
        emit(AuthInitial());
      });
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
