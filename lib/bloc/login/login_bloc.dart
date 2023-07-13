import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      await loginUser(emit, event);
    });
  }

  Future<void> loginUser(Emitter<LoginState> emit, LoginEvent event) async {
    if(event is LoginButtonPressed){
      print('LoginButtonPressed: Username: ${event.username}, Password: ${event.password}');
      emit(LoginLoading());
      try {
        // Simulating login request with a delay
        await Future.delayed(const Duration(seconds: 2));
        final isAuthenticated = true ;//TODO() await repository.authenticate(event.username, event.password);
        if (isAuthenticated) {
          emit(LoginSuccess());
        } else {
          emit(LoginFailure(error: 'Invalid credentials'));
        }
      } catch (error) {
        emit(LoginFailure(error: 'An error occurred'));
      }
    }

  }
}