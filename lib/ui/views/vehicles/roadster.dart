import 'package:cherry/cubits/index.dart';
import 'package:cherry/models/index.dart';
import 'package:cherry/ui/widgets/index.dart';
import 'package:cherry/utils/index.dart';
import 'package:cherry_components/cherry_components.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';
import 'package:row_item/row_item.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sliver_fab/sliver_fab.dart';

/// Displays live information about Elon Musk's Tesla Roadster.
class RoadsterPage extends StatelessWidget {
  final String id;

  const RoadsterPage(this.id, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RoadsterVehicle roadster =
        context.watch<VehiclesCubit>().getVehicle(id);
    return Scaffold(
      body: SliverFab(
        floatingWidget: SafeArea(
          top: false,
          bottom: false,
          left: false,
          child: FloatingActionButton(
            heroTag: null,
            tooltip: context.translate('spacex.other.tooltip.watch_replay'),
            onPressed: () => context.openUrl(roadster.url),
            child: Icon(Icons.ondemand_video),
          ),
        ),
        expandedHeight: MediaQuery.of(context).size.height * 0.3,
        slivers: <Widget>[
          SliverBar(
            title: roadster.name,
            header: SwiperHeader(
              list: roadster.photos,
              builder: (_, index) => CacheImage(roadster.getPhoto(index)),
            ),
            actions: <Widget>[
              IconButton(
                icon: IconShadow(Icons.adaptive.share),
                onPressed: () => Share.share(
                  context.translate(
                    'spacex.other.share.roadster',
                    parameters: {
                      'date': roadster.getLaunchDate(context),
                      'speed': roadster.getSpeed,
                      'earth_distance': roadster.getEarthDistance,
                      'details': Url.shareDetails
                    },
                  ),
                ),
                tooltip: context.translate('spacex.other.menu.share'),
              ),
            ],
            menuItemBuilder: (context) => [
              for (final item in Menu.wikipedia)
                PopupMenuItem(
                  value: item,
                  child: Text(context.translate(item)),
                )
            ],
            onMenuItemSelected: (text) => context.openUrl(roadster.url),
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverToBoxAdapter(
              child: RowLayout.cards(children: <Widget>[
                _roadsterCard(context),
                _vehicleCard(context),
                _orbitCard(context),
                ItemCell(
                  icon: Icons.refresh,
                  text: context.translate(
                    'spacex.vehicle.roadster.data_updated',
                  ),
                ),
              ],),
            ),
          ),
        ],
      ),
    );
  }

  Widget _roadsterCard(BuildContext context) {
    final RoadsterVehicle roadster =
        context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: context.translate('spacex.vehicle.roadster.description.title'),
      child: RowLayout(children: <Widget>[
        RowItem.text(
          context.translate('spacex.vehicle.roadster.description.launch_date'),
          roadster.getFullFirstFlight,
        ),
        RowItem.text(
          context.translate(
            'spacex.vehicle.roadster.description.launch_vehicle',
          ),
          'Falcon Heavy',
        ),
        Separator.divider(),
        ExpandText(roadster.description)
      ],),
    );
  }

  Widget _vehicleCard(BuildContext context) {
    final RoadsterVehicle roadster =
        context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: context.translate('spacex.vehicle.roadster.vehicle.title'),
      child: RowLayout(children: <Widget>[
        RowItem.text(
          context.translate('spacex.vehicle.roadster.vehicle.mass'),
          roadster.getMass(context),
        ),
        RowItem.text(
          context.translate('spacex.vehicle.roadster.vehicle.speed'),
          roadster.getSpeed,
        ),
        Separator.divider(),
        RowItem.text(
          context.translate('spacex.vehicle.roadster.vehicle.distance_earth'),
          roadster.getEarthDistance,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.roadster.vehicle.distance_mars'),
          roadster.getMarsDistance,
        ),
      ],),
    );
  }

  Widget _orbitCard(BuildContext context) {
    final RoadsterVehicle roadster =
        context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: context.translate('spacex.vehicle.roadster.orbit.title'),
      child: RowLayout(children: <Widget>[
        RowItem.text(
          context.translate('spacex.vehicle.roadster.orbit.type'),
          roadster.getOrbit,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.roadster.orbit.period'),
          roadster.getPeriod(context),
        ),
        Separator.divider(),
        RowItem.text(
          context.translate('spacex.vehicle.roadster.orbit.inclination'),
          roadster.getInclination,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.roadster.orbit.longitude'),
          roadster.getLongitude,
        ),
        Separator.divider(),
        RowItem.text(
          context.translate('spacex.vehicle.roadster.orbit.apoapsis'),
          roadster.getApoapsis,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.roadster.orbit.periapsis'),
          roadster.getPeriapsis,
        ),
      ],),
    );
  }
}
