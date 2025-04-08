import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimbus/core/extensions/extensions.dart';
import 'package:nimbus/core/model/user.model.dart';
import 'package:nimbus/core/service/user/User.service.dart';
import 'package:nimbus/core/utils/localization/locale_keys.g.dart';

class UserCubit extends Cubit<UserState> {
  final UserService userService = UserService();

  updateUserInfo(UserModel model, BuildContext context) async {
    final result = await userService.updateUserInfo(model);
    result.fold(
      (error) {
        return context.showFailureSnackBar(error);
      },
      (success) {
        return null;
      },
    );
  }

  deleteAccount(String userId, BuildContext context) async {
    final result = await userService.deleteAccount(userId);
    result.fold(
      (error) {
        return context.showFailureSnackBar(error);
      },
      (success) {
        context.showSuccessSnackBar(
          LocaleKeys.settings_page_delete_account_txt.locale,
        );
        return null;
      },
    );
  }

  UserCubit() : super(UserInitial());
}

abstract class UserState {}

class UserInitial extends UserState {}
