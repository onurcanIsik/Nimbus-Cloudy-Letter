import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimbus/core/extensions/extensions.dart';
import 'package:nimbus/core/model/nimbus.model.dart';
import 'package:nimbus/core/service/home/AddNimbus.service.dart';
import 'package:nimbus/core/utils/localization/locale_keys.g.dart';

class AddNimbusCubit extends Cubit<AddNimbusState> {
  final AddNimbusService addNimbusService = AddNimbusService();

  addNimbus(NimbusModel model, BuildContext context) async {
    final result = await addNimbusService.addNimbus(model);
    result.fold(
      (error) {
        context.showFailureSnackBar(error);
      },
      (success) {
        context.showSuccessSnackBar(
          LocaleKeys.read_nimbus_page_nimbus_added.locale,
        );
      },
    );
  }

  getNimbusList(BuildContext context) async {
    emit(AddNimbusLoading());
    final result = await addNimbusService.getNimbusList();
    result.fold(
      (error) {
        emit(AddNimbusFailure(error));
      },
      (success) {
        emit(AddNimbusLoaded(success));
      },
    );
  }

  getRandomNimbus(BuildContext context) async {
    emit(AddNimbusRandomLoading());
    final result = await addNimbusService.getRandomNimbus();
    result.fold(
      (error) {
        emit(AddNimbusRandomFailure(error));
        context.showFailureSnackBar(error);
      },
      (success) {
        if (success.isNotEmpty) {
          emit(AddNimbusRandomLoaded(success.first));
        } else {
          emit(
            AddNimbusRandomFailure(
              LocaleKeys.error_txt_nimbus_not_found.locale,
            ),
          );
        }
      },
    );
  }

  AddNimbusCubit() : super(AddNimbusInitial());
}

abstract class AddNimbusState {}

class AddNimbusInitial extends AddNimbusState {}

class AddNimbusLoading extends AddNimbusState {}

class AddNimbusLoaded extends AddNimbusState {
  final List<NimbusModel> nimbusList;
  AddNimbusLoaded(this.nimbusList);
}

class AddNimbusRandomLoaded extends AddNimbusState {
  final NimbusModel randomNimbus;
  AddNimbusRandomLoaded(this.randomNimbus);
}

class AddNimbusFailure extends AddNimbusState {
  final String error;
  AddNimbusFailure(this.error);
}

class AddNimbusRandomFailure extends AddNimbusState {
  final String error;
  AddNimbusRandomFailure(this.error);
}

class AddNimbusRandomLoading extends AddNimbusState {}
