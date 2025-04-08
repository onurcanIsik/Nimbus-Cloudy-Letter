// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:nimbus/core/extensions/extensions.dart';
import 'package:nimbus/core/manager/shared.manager.dart';
import 'package:nimbus/core/service/auth/Auth.service.dart';
import 'package:nimbus/core/utils/enums/router.enums.dart';
import 'package:nimbus/core/utils/enums/shared_keys.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService authService = AuthService();

  authUser(String userMail, BuildContext context) async {
    emit(AuthInitial());
    final result = await authService.signWithAnonymous(userMail);
    result.fold(
      (error) {
        return context.showFailureSnackBar(error);
      },
      (success) async {
        await SharedManager.setBool(SharedKeys.isLogin, true);
        context.router.replacePath(RouteEnums.homepagePath.value);
      },
    );
  }

  AuthCubit() : super(AuthInitial());
}

abstract class AuthState {}

class AuthInitial extends AuthState {}
