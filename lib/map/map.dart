import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../bloc/bloc_state/bloc_state.dart';
import '../bloc/blocc/bloc.dart';
import 'google_map_servies.dart';


class map_true extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocPage(),
      child: BlocConsumer<BlocPage, BlocState>(
        listener: (context, state) {},
        builder: (context, state) {
          TextEditingController textControl = TextEditingController();
          var bloc = BlocPage.get(context);
          return Column(
              children: [
                const SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 4.0, left: 4.0),
                  child: TextFormField(
                    onChanged: (value) {},
                    controller: textControl,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () async {
                          var place = await GoogleMapServicesScreen()
                              .getPlace(textControl.text);
                          bloc.goToPlace(place);
                        },
                        icon: const Icon(Icons.search),
                      ),

                      hintText: 'Search by City',

                      // border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(20))
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Expanded(
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: bloc.positionOld,
                    markers: {bloc.mMarker, bloc.lLake},
                  ),
                ),
              ],
            );


        },
      ),
    );
  }
}
