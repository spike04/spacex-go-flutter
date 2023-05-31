import 'package:cherry/utils/index.dart';
import 'package:cherry_components/cherry_components.dart';
import 'package:flutter/material.dart';
import 'package:row_collection/row_collection.dart';

/// List of past & current Patreon supporters.
/// Thanks to you all! :)
const List<String> _patreons = [
  'John Stockbridge',
  'Ahmed Al Hamada',
  'Michael Christenson II',
  'Malcolm',
  'Pierangelo Pancera',
  'Sam M',
  'Tim van der Linde',
  'David Morrow'
];

/// Dialog that appears every once in a while, with
/// the Patreon information from this app's lead developer.
Future<T> showPatreonDialog<T>(BuildContext context) {
  return showRoundDialog(
    context: context,
    title: context.translate('about.patreon.title'),
    children: [
      RowLayout(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: <Widget>[
          Text(
            context.translate('about.patreon.body_dialog'),
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.titleMedium.copyWith(
                  color: Theme.of(context).textTheme.bodySmall.color,
                ),
          ),
          for (String patreon in _patreons)
            Text(
              patreon,
              style: Theme.of(context).textTheme.titleMedium.copyWith(
                    color: Theme.of(context).textTheme.bodySmall.color,
                  ),
            ),
          if (Theme.of(context).platform != TargetPlatform.iOS)
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(
                      context.translate('about.patreon.dismiss'),
                      style: Theme.of(context).textTheme.bodyMedium.copyWith(
                            color: Theme.of(context).textTheme.bodySmall.color,
                          ),
                    ),
                  ),
                  OutlinedButton(
                    // highlightedBorderColor:
                    //     Theme.of(context).colorScheme.secondary,
                    // borderSide: BorderSide(
                    //   color: Theme.of(context).textTheme.titleLarge.color,
                    // ),
                    onPressed: () {
                      Navigator.pop(context, true);
                      context.openUrl(Url.authorPatreon);
                    },
                    child: Text(
                      'PATREON',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    ],
  );
}
