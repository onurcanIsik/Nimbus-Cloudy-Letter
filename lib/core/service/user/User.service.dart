import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nimbus/core/extensions/extensions.dart';
import 'package:nimbus/core/model/user.model.dart';
import 'package:nimbus/core/service/user/IUser.service.dart';
import 'package:nimbus/core/utils/localization/locale_keys.g.dart';

class UserService implements IUserService {
  final fb = FirebaseFirestore.instance.collection('users');
  final fba = FirebaseAuth.instance;
  @override
  Future<Either<String, Unit>> updateUserInfo(UserModel model) async {
    try {
      final userId = fba.currentUser?.uid;
      if (userId == null) {
        return left(LocaleKeys.error_txt_user_not_logged_in.locale);
      }
      final userData = fb.doc(userId);
      await userData
          .update({'lastWrite': model.lastWrite, 'lastRead': model.lastRead})
          .then((value) {
            return right(unit);
          });
      return right(unit);
    } catch (ex) {
      return left(ex.toString());
    }
  }

  @override
  Future<Either<String, Unit>> deleteAccount(String userId) async {
    try {
      final userData = fb.doc(userId);
      await userData.delete();
      await fba.currentUser?.delete();
      await fba.signOut();
      return right(unit);
    } catch (ex) {
      return left(ex.toString());
    }
  }
}
