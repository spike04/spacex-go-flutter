import 'package:cherry/cubits/index.dart';
import 'package:cherry/models/index.dart';
import 'package:cherry/ui/widgets/big_tip.dart';
import 'package:cherry/ui/widgets/index.dart';
import 'package:cherry/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_request_bloc/flutter_request_bloc.dart';
import 'package:search_page/search_page.dart';

/// This tab holds information about all kind of SpaceX's vehicles,
/// such as rockets, capsules, Tesla Roadster & ships.
class VehiclesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RequestSliverPage<VehiclesCubit, List<Vehicle>>(
        title: context.translate('spacex.vehicle.title'),
        headerBuilder: (context, state, value) {
          final photos = [
            for (final vehicle in value) vehicle.getRandomPhoto()
          ];

          return SwiperHeader(list: photos.sublist(0, 4));
        },
        popupMenu: Menu.home,
        childrenBuilder: (context, state, value) => [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => VehicleCell(value[index]),
              childCount: value.length,
            ),
          ),
        ],
      ),
      floatingActionButton: RequestBuilder<VehiclesCubit, List<Vehicle>>(
        onLoaded: (context, state, value) => FloatingActionButton(
          heroTag: null,
          tooltip: context.translate(
            'spacex.other.tooltip.search',
          ),
          onPressed: () => showSearch(
            context: context,
            delegate: SearchPage<Vehicle>(
              items: value,
              searchLabel: context.translate(
                'spacex.other.tooltip.search',
              ),
              suggestion: BigTip(
                title: Text(
                  context.translate(
                    'spacex.vehicle.title',
                  ),
                  style: Theme.of(context).textTheme.titleLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                subtitle: Text(
                  context.translate(
                    'spacex.search.suggestion.vehicle',
                  ),
                  style: Theme.of(context).textTheme.titleMedium.copyWith(
                        color: Theme.of(context).textTheme.bodySmall.color,
                      ),
                ),
                child: Icon(Icons.search),
              ),
              failure: BigTip(
                title: Text(
                  context.translate(
                    'spacex.vehicle.title',
                  ),
                  style: Theme.of(context).textTheme.titleLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                subtitle: Text(
                  context.translate(
                    'spacex.search.failure',
                  ),
                  style: Theme.of(context).textTheme.titleMedium.copyWith(
                        color: Theme.of(context).textTheme.bodySmall.color,
                      ),
                ),
                child: Icon(Icons.sentiment_dissatisfied),
              ),
              filter: (vehicle) => [
                vehicle.name,
                vehicle.year,
                vehicle.type,
              ],
              builder: (vehicle) => VehicleCell(vehicle),
            ),
          ),
          child: Icon(Icons.search),
        ),
      ),
    );
  }
}
