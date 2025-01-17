import 'package:cherry/cubits/index.dart';
import 'package:cherry/models/index.dart';
import 'package:cherry/ui/views/launches/index.dart';
import 'package:cherry/ui/widgets/index.dart';
import 'package:cherry/utils/index.dart';
import 'package:cherry_components/cherry_components.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';
import 'package:row_item/row_item.dart';
import 'package:share_plus/share_plus.dart';

/// This view all information about a specific ship. It displays Ship's specs.
class ShipPage extends StatelessWidget {
  final String id;

  const ShipPage(this.id);

  @override
  Widget build(BuildContext context) {
    final ShipVehicle ship = context.watch<VehiclesCubit>().getVehicle(id);
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverBar(
          title: ship.name,
          header: InkWell(
            onTap: () => context.openUrl(ship.getProfilePhoto),
            child: CacheImage(ship?.getProfilePhoto),
          ),
          actions: <Widget>[
            IconButton(
              icon: IconShadow(Icons.adaptive.share),
              onPressed: () => Share.share(
                context.translate(
                  'spacex.other.share.ship.body',
                  parameters: {
                    'date': ship.getBuiltFullDate,
                    'name': ship.name,
                    'role': ship.primaryRole,
                    'port': ship.homePort,
                    'missions': ship.hasMissions
                        ? context.translate(
                            'spacex.other.share.ship.missions',
                            parameters: {
                              'missions': ship.missions.length.toString()
                            },
                          )
                        : context
                            .translate('spacex.other.share.ship.any_missions'),
                    'details': Url.shareDetails
                  },
                ),
              ),
              tooltip: context.translate('spacex.other.menu.share'),
            ),
          ],
          menuItemBuilder: (context) => [
            for (final item in Menu.ship)
              PopupMenuItem(
                value: item,
                child: Text(context.translate(item)),
              )
          ],
          onMenuItemSelected: (text) => context.openUrl(ship.url),
        ),
        SliverSafeArea(
          top: false,
          sliver: SliverToBoxAdapter(
            child: RowLayout.cards(children: <Widget>[
              _shipCard(context),
              _specsCard(context),
              _missionsCard(context),
            ],),
          ),
        ),
      ],),
    );
  }

  Widget _shipCard(BuildContext context) {
    final ShipVehicle ship = context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: context.translate('spacex.vehicle.ship.description.title'),
      child: RowLayout(children: <Widget>[
        RowItem.text(
            context.translate('spacex.vehicle.ship.description.home_port'),
            ship.homePort,),
        RowItem.text(
          context.translate('spacex.vehicle.ship.description.built_date'),
          ship.getBuiltFullDate,
        ),
        Separator.divider(),
        RowItem.text(
          context.translate('spacex.vehicle.ship.specifications.feature'),
          ship.use,
        ),
        RowItem.text(
          context.translate('spacex.vehicle.ship.specifications.model'),
          ship.getModel(context),
        ),
      ],),
    );
  }

  Widget _specsCard(BuildContext context) {
    final ShipVehicle ship = context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: context.translate('spacex.vehicle.ship.specifications.title'),
      child: RowLayout(children: <Widget>[
        RowItem.text(
          context.translate('spacex.vehicle.ship.specifications.role_primary'),
          ship.primaryRole,
        ),
        if (ship.hasSeveralRoles)
          RowItem.text(
            context.translate(
              'spacex.vehicle.ship.specifications.role_secondary',
            ),
            ship.secondaryRole,
          ),
        RowItem.text(
          context.translate('spacex.vehicle.ship.specifications.status'),
          ship.getStatus(context),
        ),
        Separator.divider(),
        RowItem.text(
          context.translate('spacex.vehicle.ship.specifications.mass'),
          ship.getMass(context),
        ),
        RowItem.text(
          context.translate('spacex.vehicle.ship.specifications.speed'),
          ship.getSpeed(context),
        ),
      ],),
    );
  }

  Widget _missionsCard(BuildContext context) {
    final ShipVehicle ship = context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: context.translate('spacex.vehicle.ship.missions.title'),
      child: ship.hasMissions
          ? RowLayout(
              children: <Widget>[
                if (ship.missions.length > 5) ...[
                  for (final mission in ship.missions.sublist(0, 5))
                    RowTap(
                      context.translate(
                        'spacex.vehicle.ship.missions.mission',
                        parameters: {'number': mission.flightNumber.toString()},
                      ),
                      mission.name,
                      onTap: () => Navigator.pushNamed(
                        context,
                        LaunchPage.route,
                        arguments: {'id': mission.id},
                      ),
                    ),
                  ExpandChild(
                    child: RowLayout(
                      children: <Widget>[
                        for (final mission in ship.missions.sublist(5))
                          RowTap(
                            context.translate(
                              'spacex.vehicle.ship.missions.mission',
                              parameters: {
                                'number': mission.flightNumber.toString()
                              },
                            ),
                            mission.name,
                            onTap: () => Navigator.pushNamed(
                              context,
                              LaunchPage.route,
                              arguments: {'id': mission.id},
                            ),
                          ),
                      ],
                    ),
                  )
                ] else
                  for (final mission in ship.missions)
                    RowTap(
                      context.translate(
                        'spacex.vehicle.ship.missions.mission',
                        parameters: {'number': mission.flightNumber.toString()},
                      ),
                      mission.name,
                      onTap: () => Navigator.pushNamed(
                        context,
                        LaunchPage.route,
                        arguments: {'id': mission.id},
                      ),
                    ),
              ],
            )
          : Text(
              context.translate('spacex.vehicle.ship.missions.no_missions'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).textTheme.bodySmall.color,
              ),
            ),
    );
  }
}
