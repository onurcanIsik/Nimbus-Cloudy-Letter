// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nimbus/colors/colors.dart';
import 'package:nimbus/core/bloc/add_nimbus.bloc.dart';
import 'package:nimbus/core/extensions/extensions.dart';
import 'package:nimbus/core/model/nimbus.model.dart';
import 'package:nimbus/core/utils/localization/locale_keys.g.dart';

@RoutePage()
class AddNimbusPage extends HookWidget {
  const AddNimbusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final isClicked = useState<bool>(false);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/nimbus_logo_nobg.png',
              width: 50,
              height: 50,
            ),
            Text('Nimbus', style: GoogleFonts.poppins()),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            spacing: 30,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return LocaleKeys
                          .add_nimbus_page_enter_nimbus_title
                          .locale;
                    }
                    return null;
                  },
                  maxLength: 36,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.add_nimbus_page_title.locale,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: context.dynamicHeight(0.4),
                  child: TextFormField(
                    controller: descriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return LocaleKeys
                            .add_nimbus_page_enter_nimbus_content
                            .locale;
                      }
                      return null;
                    },
                    expands: true,
                    maxLines: null,
                    minLines: null,
                    maxLength: 256,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      labelText: LocaleKeys.add_nimbus_page_content.locale,
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
              ),
              isClicked.value == false
                  ? ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        isClicked.value = true;
                        final position = await Geolocator.getCurrentPosition();
                        await context.read<AddNimbusCubit>().addNimbus(
                          NimbusModel(
                            nimTitle: titleController.text,
                            nimBody: descriptionController.text,
                            isRead: false,
                            nimSenderId: userId,
                            nimDate: DateTime.now().toIso8601String(),
                            nimLoc: {
                              'latitude': position.latitude,
                              'longitude': position.longitude,
                            },
                            nimId:
                                DateTime.now().millisecondsSinceEpoch
                                    .toString(),
                          ),
                          context,
                        );

                        await context.read<AddNimbusCubit>().getNimbusList(
                          context,
                        );

                        titleController.clear();
                        descriptionController.clear();
                        isClicked.value = false;
                      }
                    },
                    child: Text('Nimbus'),
                  )
                  : Center(child: CircularProgressIndicator(color: logoColor)),
            ],
          ),
        ),
      ),
    );
  }
}
