import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:nimbus/core/model/user.model.dart';
import 'package:nimbus/core/service/auth/IAuth.service.dart';

class AuthService implements IAuthService {
  final fb = FirebaseFirestore.instance.collection('users');

  @override
  Future<Either<String, Unit>> signWithAnonymous(String userMail) async {
    // todo: implement signWithAnonymous
    try {
      final box = await Hive.openBox('userBox');
      final userLoc = box.get('userLoc');
      final _ = await FirebaseAuth.instance.signInAnonymously();
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        return left('User is null');
      }
      final userData =
          UserModel(
            userId: user.uid,
            email: userMail,
            createdAt: DateTime.now(),
            userLoc: userLoc,
          ).toJson();

      await fb.doc(user.uid).set(userData);
      return right(unit);
    } catch (ex) {
      print(ex);
      return left(ex.toString());
    }
  }
}
