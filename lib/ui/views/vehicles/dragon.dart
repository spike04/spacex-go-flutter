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

/// This view all information about a Dragon capsule model. It displays CapsuleInfo's specs.
class DragonPage extends StatelessWidget {
  final String id;

  const DragonPage(this.id);

  @override
  Widget build(BuildContext context) {
    final DragonVehicle dragon = context.watch<VehiclesCubit>().getVehicle(id);
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverBar(
          title: dragon.name,
          header: SwiperHeader(
            list: dragon.photos,
            builder: (_, index) => CacheImage(dragon.getPhoto(index)),
          ),
          actions: <Widget>[
            IconButton(
              icon: IconShadow(Icons.adaptive.share),
              onPressed: () => Share.share(
                context.translate(
                  'spacex.other.share.capsule.body',
                  parameters: {
                    'name': dragon.name,
                    'launch_payload': dragon.getLaunchMass,
                    'return_payload': dragon.getReturnMass,
                    'people': dragon.isCrewEnabled
                        ? context.translate(
                            'spacex.other.share.capsule.people',
                            parameters: {'people': dragon.crew.toString()},
                          )
                        : context
                            .translate('spacex.other.share.capsule.no_people'),
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
          onMenuItemSelected: (text) => context.openUrl(dragon.url),
        ),
        SliverSafeArea(
          top: false,
          sliver: SliverToBoxAdapter(
            child: RowLayout.cards(children: <Widget>[
              _capsuleCard(context),
              _specsCard(context),
              _thrustersCard(context),
            ],),
          ),
        ),
      ],),
    );
  }

  Widget _capsuleCard(BuildContext context) {
    final DragonVehicle dragon = context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: context.translate('spacex.vehicle.capsule.description.title'),
      child: RowLayout(children: <Widget>[
        RowItem.text(
          context.translate('spacex.vehicle.capsule.description.launch_maiden'),
          dragon.getFullFirstFlight,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.capsule.description.crew_capacity'),
          dragon.getCrew(context),
        ),
        RowItem.boolean(
          context.translate('spacex.vehicle.capsule.description.active'),
          dragon.active,
        ),
        Separator.divider(),
        ExpandText(dragon.description)
      ],),
    );
  }

  Widget _specsCard(BuildContext context) {
    final DragonVehicle dragon = context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: context.translate('spacex.vehicle.capsule.specifications.title'),
      child: RowLayout(children: <Widget>[
        RowItem.text(
          context.translate(
            'spacex.vehicle.capsule.specifications.payload_launch',
          ),
          dragon.getLaunchMass,
        ),
        RowItem.text(
          context.translate(
            'spacex.vehicle.capsule.specifications.payload_return',
          ),
          dragon.getReturnMass,
        ),
        RowItem.boolean(
          context.translate('spacex.vehicle.capsule.description.reusable'),
          dragon.reusable,
        ),
        Separator.divider(),
        RowItem.text(
          context.translate('spacex.vehicle.capsule.specifications.height'),
          dragon.getHeight,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.capsule.specifications.diameter'),
          dragon.getDiameter,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.capsule.specifications.mass'),
          dragon.getMass(context),
        ),
      ],),
    );
  }

  Widget _thrustersCard(BuildContext context) {
    final DragonVehicle dragon = context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: context.translate('spacex.vehicle.capsule.thruster.title'),
      child: RowLayout(children: <Widget>[
        for (final thruster in dragon.thrusters)
          _getThruster(
            context: context,
            thruster: thruster,
            isFirst: dragon.thrusters.first == thruster,
          ),
      ],),
    );
  }

  Widget _getThruster({BuildContext context, Thruster thruster, bool isFirst}) {
    return RowLayout(children: <Widget>[
      if (!isFirst) Separator.divider(),
      RowItem.text(
        context.translate('spacex.vehicle.capsule.thruster.model'),
        thruster.model,
      ),
      RowItem.text(
        context.translate('spacex.vehicle.capsule.thruster.amount'),
        thruster.getAmount,
      ),
      RowItem.text(
        context.translate('spacex.vehicle.capsule.thruster.fuel'),
        thruster.getFuel,
      ),
      RowItem.text(
        context.translate('spacex.vehicle.capsule.thruster.oxidizer'),
        thruster.getOxidizer,
      ),
      RowItem.text(
        context.translate('spacex.vehicle.capsule.thruster.thrust'),
        thruster.getThrust,
      ),
      RowItem.text(
        context.translate('spacex.vehicle.capsule.thruster.isp'),
        thruster.getIsp,
      ),
    ],);
  }
}
