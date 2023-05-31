import 'package:cherry/models/index.dart';
import 'package:cherry/ui/views/vehicles/index.dart';
import 'package:cherry/ui/widgets/index.dart';
import 'package:cherry_components/cherry_components.dart';
import 'package:flutter/material.dart';
import 'package:row_collection/row_collection.dart';

class VehicleCell extends StatelessWidget {
  final Vehicle vehicle;

  const VehicleCell(this.vehicle, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ListCell(
        leading: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: ProfileImage.small(vehicle.getProfilePhoto),
        ),
        title: vehicle.name,
        subtitle: vehicle.subtitle(context),
        onTap: () => Navigator.pushNamed(
          context,
          VehiclePage.route,
          arguments: {'id': vehicle.id},
        ),
      ),
      Separator.divider(indent: 72)
    ],);
  }
}
