import 'package:cherry/models/index.dart';
import 'package:cherry/ui/views/launches/index.dart';
import 'package:cherry/ui/widgets/index.dart';
import 'package:cherry_components/cherry_components.dart';
import 'package:flutter/material.dart';
import 'package:row_collection/row_collection.dart';

class LaunchCell extends StatelessWidget {
  final Launch launch;

  const LaunchCell(this.launch, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ListCell(
        leading: ProfileImage.small(launch.patchUrl),
        title: launch.name,
        subtitle: launch.getLaunchDate(context),
        trailing: TrailingText(launch.getNumber),
        onTap: () => Navigator.pushNamed(
          context,
          LaunchPage.route,
          arguments: {'id': launch.id},
        ),
      ),
      Separator.divider(indent: 72)
    ],);
  }
}
