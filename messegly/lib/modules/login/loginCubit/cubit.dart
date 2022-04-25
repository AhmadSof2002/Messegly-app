import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messegly/modules/login/loginCubit/states.dart';
import 'package:messegly/shared/components/constants.dart';
import 'package:messegly/shared/network/local/cache_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPassShown = true;

  IconData? suffixIcon = Icons.visibility_outlined;

  void changePassVision() {
    isPassShown = !isPassShown;

    suffixIcon =
        isPassShown ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePassVisibilityState());
  }

  void emailPassLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      CacheHelper.saveData(key: 'uId', value: uId);
      emit(LoginSuccessState(value.user!.uid));
      print('login succesed');
    }).catchError((error) {
      print(error);
      emit(LoginErrorState(error.toString()));
    });
  }
}
