// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimbus/core/bloc/add_nimbus.bloc.dart';
import 'package:nimbus/core/components/home_appbar.widget.dart';
import 'package:nimbus/core/extensions/extensions.dart';
import 'package:nimbus/core/model/nimbus.model.dart';
import 'package:nimbus/core/theme/theme.provider.dart';
import 'package:nimbus/core/utils/localization/locale_keys.g.dart';
import 'package:nimbus/pages/home/read_nimbus.dart';
import 'package:provider/provider.dart';

@RoutePage()
class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: BlocListener<AddNimbusCubit, AddNimbusState>(
          listener: (context, state) async {
            if (state is AddNimbusRandomLoaded) {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ReadNimbusPage(
                        nimbusTitle: state.randomNimbus.nimTitle!,
                        nimbusDescription: state.randomNimbus.nimBody!,
                        nimDate: state.randomNimbus.nimDate!,
                      ),
                ),
              );
            }
            if (state is AddNimbusRandomFailure) {
              context.read<AddNimbusCubit>().getNimbusList(context);
            }
          },
          child: Center(
            child: Column(
              children: [
                HomeAppbarWidget(),
                BlocBuilder<AddNimbusCubit, AddNimbusState>(
                  builder: (context, state) {
                    if (state is AddNimbusLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is AddNimbusFailure) {
                      return Center(child: Text(state.error));
                    } else if (state is AddNimbusLoaded) {
                      final nimbData = state.nimbusList;
                      return _buildBody(
                        context,
                        nimbData,
                        userId!,
                        themeProvider,
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
                Container(
                  width: context.dynamicWidth(1),
                  height: context.dynamicHeight(0.07),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                    ),
                    onPressed: () {
                      context.read<AddNimbusCubit>().getRandomNimbus(context);
                    },
                    child: Text(LocaleKeys.homepage_read_daily_nimbus.locale),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    List<NimbusModel> nimbData,
    String userId,
    ThemeProvider themeProvider,
  ) {
    final userNimb =
        nimbData.where((element) => element.nimSenderId == userId).toList();

    return Expanded(
      child: GridView.builder(
        itemCount: userNimb.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 50,
              backgroundColor:
                  themeProvider.isDarkMode
                      ? Colors.white.withAlpha(100)
                      : Colors.black.withAlpha(150),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: AutoSizeText(
                  userNimb[index].nimTitle!,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  minFontSize: 8,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
