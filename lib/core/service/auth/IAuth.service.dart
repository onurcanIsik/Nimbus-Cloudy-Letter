import 'package:dartz/dartz.dart';

abstract class IAuthService {
  Future<Either<String, Unit>> signWithAnonymous(String userMail);
}
