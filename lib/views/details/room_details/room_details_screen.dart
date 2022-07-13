import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/derived_components/appbar_options.dart';
import 'package:hospital_database_app/derived_components/provided_appbar.dart';
import 'package:hospital_database_app/providers/appbar_provider.dart';
import 'package:hospital_database_app/providers/details_provider.dart';
import 'package:hospital_database_app/views/details/room_details/room_details_screen_body.dart';
import 'package:provider/provider.dart';

class RoomDetailsScreen extends StatelessWidget {
  const RoomDetailsScreen({Key? key}) : super(key: key);

  static const id = '/details/room';

  @override
  Widget build(BuildContext context) {
    final appBarProvider = context.read<AppBarProvider>();

    return ChangeNotifierProvider(
      create: (context) => DetailsProvider(
        tableType: TableType.rooms,
      ),
      child: GestureDetector(
        onTap: appBarProvider.unshowOptions,
        child: Scaffold(
          appBar: const ProvidedAppBar(isHome: false),
          backgroundColor: Colors.white,
          body: Stack(
            clipBehavior: Clip.none,
            children: const [
              RoomDetailsScreenBody(),
              AppBarOptions(),
            ],
          ),
        ),
      ),
    );
  }
}
