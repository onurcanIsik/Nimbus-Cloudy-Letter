import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nimbus/colors/colors.dart';
import 'package:nimbus/core/bloc/auth.bloc.dart';
import 'package:nimbus/core/extensions/extensions.dart';
import 'package:nimbus/core/utils/localization/locale_keys.g.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

@RoutePage()
class LoginPage extends HookWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final isLoading = useState<bool>(false);
    final isAgreed = useState<bool>(false);

    return Scaffold(
      body: Form(
        key: formKey,
        child: Center(
          child: Container(
            height: context.dynamicHeight(0.7),
            width: context.dynamicWidth(0.8),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/nimbus_logo_nobg.png',
                  width: 200,
                  height: 200,
                ),
                Padding(
                  padding: context.paddingAll * 2,
                  child: TextFormField(
                    controller: emailController,
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return LocaleKeys.error_txt_cannot_empty.locale;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: LocaleKeys.login_page_email_txt.locale,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child:
                      isLoading.value == false
                          ? ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate() &&
                                  isAgreed.value) {
                                isLoading.value = true;
                                await context.read<AuthCubit>().authUser(
                                  emailController.text,
                                  context,
                                );
                                isLoading.value = false;
                              } else {
                                // Kullanıcı sözleşmeyi onaylamadan login olamaz.
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      LocaleKeys.login_page_aggree_kvkk.locale,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              LocaleKeys.login_page_login_txt.locale,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: bgColor,
                              ),
                            ),
                          )
                          : Center(
                            child: CircularProgressIndicator(color: bgColor),
                          ),
                ),
                // Sözleşmeyi onaylama kutusu
                CheckboxListTile(
                  title: Text(LocaleKeys.login_page_kvkk.locale),
                  value: isAgreed.value,
                  onChanged: (bool? value) {
                    isAgreed.value = value ?? false;
                  },
                ),
                // Sözleşmeleri görmek için butonlar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed:
                          () => _showPdfViewer(
                            context,
                            'assets/pdf/nimbus_kvkk_en.pdf',
                          ),
                      child: Text('EN'),
                    ),
                    TextButton(
                      onPressed:
                          () => _showPdfViewer(
                            context,
                            'assets/pdf/nimbus_kvkk.pdf',
                          ),
                      child: Text('TR'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // PDF görüntüleyiciyi açan fonksiyon
  void _showPdfViewer(BuildContext context, String pdfAssetPath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => Scaffold(
              appBar: AppBar(title: Text('Sözleşme')),
              body: SfPdfViewer.asset(pdfAssetPath),
            ),
      ),
    );
  }
}
