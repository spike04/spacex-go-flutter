import 'package:cherry/cubits/index.dart';
import 'package:cherry/ui/views/general/index.dart';
import 'package:cherry/ui/views/vehicles/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehiclePage extends StatelessWidget {
  final String vehicleId;

  static const route = '/vehicle';

  const VehiclePage({Key key, this.vehicleId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (context.watch<VehiclesCubit>().getVehicle(vehicleId).type) {
      case 'rocket':
        return RocketPage(vehicleId);
      case 'capsule':
        return DragonPage(vehicleId);
      case 'ship':
        return ShipPage(vehicleId);
      case 'roadster':
        return RoadsterPage(vehicleId);
      default:
        return ErrorScreen();
    }
  }
}
