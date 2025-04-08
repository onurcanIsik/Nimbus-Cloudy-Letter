// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nimbus/colors/colors.dart';
import 'package:nimbus/core/bloc/add_nimbus.bloc.dart';
import 'package:nimbus/core/extensions/extensions.dart';
import 'package:nimbus/core/model/nimbus.model.dart';
import 'package:nimbus/core/utils/enums/router.enums.dart';
import 'package:nimbus/core/utils/localization/locale_keys.g.dart';

class HomeAppbarWidget extends StatefulWidget {
  const HomeAppbarWidget({super.key});

  @override
  State<HomeAppbarWidget> createState() => _HomeAppbarWidgetState();
}

class _HomeAppbarWidgetState extends State<HomeAppbarWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNimbusCubit, AddNimbusState>(
      builder: (context, state) {
        if (state is AddNimbusLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AddNimbusFailure) {
          return Center(child: Text(state.error));
        } else if (state is AddNimbusLoaded) {
          final nimbData = state.nimbusList;
          return _buildAppBar(context, nimbData);
        }
        return SizedBox.shrink();
      },
    );
  }

  _buildAppBar(BuildContext context, List<NimbusModel> nimbData) {
    return Container(
      width: context.dynamicWidth(1),
      height: context.dynamicHeight(0.155),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        border: Border.all(width: 2),
        color: darkBgColor,
        boxShadow: [
          BoxShadow(
            color: darkIconColor.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            LocaleKeys.homepage_total_nimbus.locale,
            style: GoogleFonts.poppins(color: bgColor),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  context.router.pushNamed(RouteEnums.addNimbusPath.value);
                },
                icon: Icon(Icons.add, color: bgColor),
              ),
              Image.asset(
                'assets/images/nimbus_logo_nobg.png',
                width: 70,
                height: 70,
              ),

              IconButton(
                onPressed: () {
                  context.router.pushNamed(RouteEnums.settingsPath.value);
                },
                icon: Icon(Icons.settings, color: bgColor),
              ),
            ],
          ),
          Text(
            nimbData.length.toString(),
            style: GoogleFonts.poppins(color: logoColor),
          ),
        ],
      ),
    );
  }
}
