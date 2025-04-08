// ignore_for_file: invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nimbus/core/extensions/extensions.dart';
import 'package:nimbus/core/model/nimbus.model.dart';
import 'package:nimbus/core/service/home/IAddNimbus.service.dart';
import 'package:nimbus/core/utils/localization/locale_keys.g.dart';

class AddNimbusService implements IAddNimbusService {
  final fb = FirebaseFirestore.instance.collection('nimbus');
  final fbu = FirebaseFirestore.instance.collection('users');
  final fba = FirebaseAuth.instance;

  @override
  Future<Either<String, Unit>> addNimbus(NimbusModel model) async {
    try {
      final userDoc = await fbu.doc(fba.currentUser?.uid).get();
      final userLastWrite =
          userDoc.data()?['lastWrite'] != null
              ? DateTime.parse(userDoc['lastWrite'])
              : null;

      if (canWriteToday(userLastWrite)) {
        await fb
            .add(model.toJson())
            .then((value) {
              return right(unit);
            })
            .catchError((error) {
              return left(error);
            });
        await FirebaseFirestore.instance
            .collection('users')
            .doc(fba.currentUser?.uid)
            .update({'lastWrite': DateTime.now().toIso8601String()});
      } else {
        return left(LocaleKeys.error_txt_already_add_nimbus.locale);
      }

      return right(unit);
    } catch (e) {
      return left(e.toString());
    }
  }

  bool canWriteToday(DateTime? lastWriteDate) {
    if (lastWriteDate == null) return true;
    final now = DateTime.now();
    return now.year != lastWriteDate.year ||
        now.month != lastWriteDate.month ||
        now.day != lastWriteDate.day;
  }

  @override
  Future<Either<String, List<NimbusModel>>> getNimbusList() async {
    try {
      final snapshot = await fb.get();
      final nimbusList =
          snapshot.docs
              .map((doc) => doc.data())
              .whereType<Map<String, dynamic>>()
              .map((data) => NimbusModel.fromJson(data))
              .toList();
      return right(nimbusList);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<NimbusModel>>> getRandomNimbus() async {
    try {
      final userId = fba.currentUser?.uid;
      if (userId == null) {
        return left(LocaleKeys.error_txt_user_not_found.locale);
      }
      final userDoc = await fbu.doc(userId).get();
      final lastReadRaw = userDoc.data()?['lastRead'];
      final lastRead =
          lastReadRaw != null ? DateTime.tryParse(lastReadRaw) : null;
      if (!canReadToday(lastRead)) {
        return left(LocaleKeys.error_txt_already_read_nimbus.locale);
      }
      final snapshot = await fb.get();
      // Kullanıcının kendisine ait olmayan nimbus'ları filtrele
      final othersNimbus =
          snapshot.docs
              .where((doc) => doc.data()['nimSenderId'] != userId)
              .map((doc) => NimbusModel.fromJson(doc.data()))
              .toList();
      if (othersNimbus.isEmpty) {
        return left(LocaleKeys.error_txt_nimbus_not_found.locale);
      }
      othersNimbus.shuffle();
      final selected = othersNimbus.first;
      // lastRead güncelle
      await fbu.doc(userId).update({
        'lastRead': DateTime.now().toIso8601String(),
      });

      return right([selected]);
    } catch (ex) {
      return left(ex.toString());
    }
  }

  bool canReadToday(DateTime? lastReadDate) {
    if (lastReadDate == null) return true;
    final now = DateTime.now();
    return now.year != lastReadDate.year ||
        now.month != lastReadDate.month ||
        now.day != lastReadDate.day;
  }
}
