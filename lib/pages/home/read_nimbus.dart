import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nimbus/core/extensions/extensions.dart';
import 'package:nimbus/core/utils/localization/locale_keys.g.dart';

class ReadNimbusPage extends StatelessWidget {
  final String? nimbusTitle;
  final String? nimbusDescription;
  final String? nimDate;
  const ReadNimbusPage({
    super.key,
    this.nimbusTitle,
    this.nimbusDescription,
    this.nimDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/nimbus_logo_nobg.png',
              width: 50,
              height: 50,
            ),
            Text(LocaleKeys.read_nimbus_page_read_nimbus_txt.locale),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: context.dynamicWidth(0.9),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AutoSizeText(
                      nimbusTitle ?? LocaleKeys.add_nimbus_page_title.locale,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AutoSizeText(
                      nimbusDescription ??
                          LocaleKeys.add_nimbus_page_content.locale,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
