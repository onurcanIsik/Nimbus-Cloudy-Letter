import 'package:dartz/dartz.dart';
import 'package:nimbus/core/model/user.model.dart';

abstract class IUserService {
  Future<Either<String, Unit>> updateUserInfo(UserModel model);
  Future<Either<String, Unit>> deleteAccount(String userId);
}
