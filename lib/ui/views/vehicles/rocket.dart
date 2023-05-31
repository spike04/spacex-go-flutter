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

/// This view all information about a Falcon rocket model. It displays RocketInfo's specs.
class RocketPage extends StatelessWidget {
  final String id;

  const RocketPage(this.id);

  @override
  Widget build(BuildContext context) {
    final RocketVehicle rocket = context.watch<VehiclesCubit>().getVehicle(id);
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverBar(
          title: rocket.name,
          header: SwiperHeader(
            list: rocket.photos,
            builder: (_, index) => CacheImage(rocket.getPhoto(index)),
          ),
          actions: <Widget>[
            IconButton(
              icon: IconShadow(Icons.adaptive.share),
              onPressed: () => Share.share(
                context.translate(
                  'spacex.other.share.rocket',
                  parameters: {
                    'name': rocket.name,
                    'height': rocket.getHeight,
                    'engines': rocket.firstStage.engines.toString(),
                    'type': rocket.engine.getName,
                    'thrust': rocket.firstStage.getThrust,
                    'payload': rocket.payloadWeights[0].getMass,
                    'orbit': rocket.payloadWeights[0].name,
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
          onMenuItemSelected: (text) => context.openUrl(rocket.url),
        ),
        SliverSafeArea(
          top: false,
          sliver: SliverToBoxAdapter(
            child: RowLayout.cards(children: <Widget>[
              _rocketCard(context),
              _specsCard(context),
              _payloadsCard(context),
              _stages(context),
              _enginesCard(context),
            ],),
          ),
        ),
      ],),
    );
  }

  Widget _rocketCard(BuildContext context) {
    final RocketVehicle rocket = context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: context.translate('spacex.vehicle.rocket.description.title'),
      child: RowLayout(children: <Widget>[
        RowItem.text(
          context.translate('spacex.vehicle.rocket.description.launch_maiden'),
          rocket.getFullFirstFlight,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.description.launch_cost'),
          rocket.getLaunchCost,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.description.success_rate'),
          rocket.getSuccessRate(context),
        ),
        RowItem.boolean(
          context.translate('spacex.vehicle.rocket.description.active'),
          rocket.active,
        ),
        Separator.divider(),
        ExpandText(rocket.description)
      ],),
    );
  }

  Widget _specsCard(BuildContext context) {
    final RocketVehicle rocket = context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: context.translate('spacex.vehicle.rocket.specifications.title'),
      child: RowLayout(children: <Widget>[
        RowItem.text(
          context
              .translate('spacex.vehicle.rocket.specifications.rocket_stages'),
          rocket.getStages(context),
        ),
        Separator.divider(),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.specifications.height'),
          rocket.getHeight,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.specifications.diameter'),
          rocket.getDiameter,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.specifications.mass'),
          rocket.getMass(context),
        ),
        Separator.divider(),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.stage.fairing_height'),
          rocket.fairingHeight(context),
        ),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.stage.fairing_diameter'),
          rocket.fairingDiameter(context),
        ),
      ],),
    );
  }

  Widget _payloadsCard(BuildContext context) {
    final RocketVehicle rocket = context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: context.translate('spacex.vehicle.rocket.capability.title'),
      child: RowLayout(
        children: <Widget>[
          for (final payloadWeight in rocket.payloadWeights)
            RowItem.text(
              payloadWeight.name,
              payloadWeight.getMass,
            ),
        ],
      ),
    );
  }

  Widget _stages(BuildContext context) {
    final RocketVehicle rocket = context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: context.translate('spacex.vehicle.rocket.stage.title'),
      child: RowLayout(children: <Widget>[
        RowItem.text(
          context.translate('spacex.vehicle.rocket.stage.thrust_first_stage'),
          rocket.firstStage.getThrust,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.stage.fuel_amount'),
          rocket.firstStage.getFuelAmount(context),
        ),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.stage.engines'),
          rocket.firstStage.getEngines(context),
        ),
        RowItem.boolean(
          context.translate('spacex.vehicle.rocket.stage.reusable'),
          rocket.firstStage.reusable,
        ),
        Separator.divider(),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.stage.thrust_second_stage'),
          rocket.secondStage.getThrust,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.stage.fuel_amount'),
          rocket.secondStage.getFuelAmount(context),
        ),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.stage.engines'),
          rocket.secondStage.getEngines(context),
        ),
        RowItem.boolean(
          context.translate('spacex.vehicle.rocket.stage.reusable'),
          rocket.secondStage.reusable,
        ),
      ],),
    );
  }

  Widget _enginesCard(BuildContext context) {
    final engine =
        (context.watch<VehiclesCubit>().getVehicle(id) as RocketVehicle).engine;

    return CardCell.body(
      context,
      title: context.translate('spacex.vehicle.rocket.engines.title'),
      child: RowLayout(children: <Widget>[
        RowItem.text(
          context.translate('spacex.vehicle.rocket.engines.model'),
          engine.getName,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.engines.thrust_weight'),
          engine.getThrustToWeight(context),
        ),
        Separator.divider(),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.engines.fuel'),
          engine.getFuel,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.engines.oxidizer'),
          engine.getOxidizer,
        ),
        Separator.divider(),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.engines.thrust_sea'),
          engine.getThrustSea,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.engines.thrust_vacuum'),
          engine.getThrustVacuum,
        ),
        Separator.divider(),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.engines.isp_sea'),
          engine.getIspSea,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.rocket.engines.isp_vacuum'),
          engine.getIspVacuum,
        ),
      ],),
    );
  }
}
