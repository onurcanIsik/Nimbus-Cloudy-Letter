// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nimbus/colors/colors.dart';
import 'package:nimbus/core/extensions/extensions.dart';
import 'package:nimbus/core/manager/shared.manager.dart';
import 'package:nimbus/core/utils/enums/router.enums.dart';
import 'package:nimbus/core/utils/enums/shared_keys.dart';
import 'package:nimbus/core/utils/localization/locale_keys.g.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isError = false;
  String errorMessage = '';
  final userIsLogin = SharedManager.getBool(SharedKeys.isLogin) ?? false;

  @override
  void initState() {
    super.initState();
    _startInitialization();
  }

  Future<void> _startInitialization() async {
    await Hive.initFlutter();
    await Hive.openBox('userBox');

    await _checkConnectivityLoop();
    if (userIsLogin) {
      context.router.replacePath(RouteEnums.homepagePath.value);
    } else {
      context.router.replacePath(RouteEnums.loginPath.value);
    }
  }

  Future<void> _checkConnectivityLoop() async {
    while (mounted) {
      final isConnected =
          await InternetConnectionChecker.instance.hasConnection;

      if (isConnected) {
        await _getLocation();
        if (!mounted) return;
        context.router.replacePath(RouteEnums.loginPath.value);
        break;
      } else {
        setState(() {
          isError = true;
          errorMessage = LocaleKeys.splash_page_connecttion_error.locale;
        });
        await Future.delayed(const Duration(seconds: 3));
      }
    }
  }

  Future<void> _getLocation() async {
    final box = Hive.box('userBox');
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    if (!serviceEnabled) {
      context.showFailureSnackBar(LocaleKeys.splash_page_location_error.locale);
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        context.showFailureSnackBar(
          LocaleKeys.splash_page_location_permission_error.locale,
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      context.showFailureSnackBar(
        LocaleKeys.splash_page_location_permission_error_2.locale,
      );
      return;
    }

    final position = await Geolocator.getCurrentPosition();
    await box.put('userLoc', {
      'latitude': position.latitude,
      'longitude': position.longitude,
    });
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/images/nimbus_nobg.png'),
      logoWidth: 200,
      loaderColor: logoColor,
      backgroundColor: bgColor,
      loadingText: Text(
        isError ? errorMessage : 'v1.0.0',
        style: GoogleFonts.poppins(),
      ),
    );
  }
}
