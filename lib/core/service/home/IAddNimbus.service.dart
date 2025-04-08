import 'package:dartz/dartz.dart';
import 'package:nimbus/core/model/nimbus.model.dart';

abstract class IAddNimbusService {
  Future<Either<String, Unit>> addNimbus(NimbusModel model);
  Future<Either<String, List<NimbusModel>>> getNimbusList();
  Future<Either<String, List<NimbusModel>>> getRandomNimbus();
}
