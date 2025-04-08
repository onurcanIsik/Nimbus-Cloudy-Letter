import 'package:auto_route/annotations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nimbus/core/bloc/user.bloc.dart';
import 'package:nimbus/core/extensions/extensions.dart';
import 'package:nimbus/core/theme/theme.provider.dart';
import 'package:nimbus/core/utils/localization/locale_keys.g.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userId = FirebaseAuth.instance.currentUser?.uid;
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.settings_page_settings_txt.locale)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: ListTile(
                    title:
                        index == 0
                            ? Text(
                              LocaleKeys.settings_page_dark_mode_txt.locale,
                            )
                            : Text(
                              LocaleKeys
                                  .settings_page_delete_account_txt
                                  .locale,
                            ),

                    trailing:
                        index == 0
                            ? Switch(
                              value: themeProvider.isDarkMode,
                              onChanged: (value) {
                                themeProvider.toggleTheme();
                              },
                            )
                            : IconButton(
                              onPressed: () {
                                context.myShowDialog(() {
                                  context.read<UserCubit>().deleteAccount(
                                    userId!,
                                    context,
                                  );
                                });
                              },
                              icon: Icon(Icons.delete),
                            ),
                  ),
                );
              },
              itemCount: 2,
            ),
          ),
        ],
      ),
    );
  }
}
