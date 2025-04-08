import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimbus/core/bloc/add_nimbus.bloc.dart';
import 'package:nimbus/core/bloc/auth.bloc.dart';
import 'package:nimbus/core/bloc/user.bloc.dart';
import 'package:nimbus/core/constant/constant.dart';
import 'package:nimbus/core/manager/shared.manager.dart';
import 'package:nimbus/core/theme/theme.provider.dart';
import 'package:nimbus/core/theme/thems.dart';
import 'package:nimbus/core/utils/localization/language.manager.dart';
import 'package:nimbus/core/utils/router/app_router.dart';
import 'package:nimbus/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
  await SharedManager.init();
  runApp(
    EasyLocalization(
      supportedLocales: LanguageManager.instance.supportedLocales,
      path: ApplicationConstants.LANG_ASSET_PATH,
      fallbackLocale: LanguageManager.instance.supportedLocales.first,
      child: ChangeNotifierProvider<ThemeProvider>(
        create: (context) => ThemeProvider(),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AppRouter appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<AddNimbusCubit>(
          create: (context) => AddNimbusCubit()..getNimbusList(context),
        ),
        BlocProvider<UserCubit>(create: (context) => UserCubit()),
      ],
      child: MaterialApp.router(
        theme:
            themeProvider.isDarkMode
                ? ThemsClass().darkTheme
                : ThemsClass().lightTheme,
        routerDelegate: appRouter.delegate(),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        routeInformationParser: appRouter.defaultRouteParser(),
      ),
    );
  }
}
