import 'package:cherry/models/index.dart';
import 'package:cherry/utils/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LaunchUtils', () {
    final launches = [
      [
        Launch(
          id: '0',
          upcoming: true,
          launchDate: DateTime.now().add(Duration(days: 1)),
        ),
        Launch(
          id: '1',
          upcoming: true,
          launchDate: DateTime.now().add(Duration(days: 2)),
        ),
      ],
      [
        Launch(
          id: '2',
          upcoming: false,
          launchDate: DateTime.now().subtract(Duration(days: 1)),
        ),
        Launch(
          id: '3',
          upcoming: false,
          launchDate: DateTime.now().subtract(Duration(days: 2)),
        ),
      ]
    ];

    test('returns upcoming launch correctly', () {
      expect(LaunchUtils.getUpcomingLaunch(launches).id, '0');
    });

    test('returns latest launch correctly', () {
      expect(LaunchUtils.getLatestLaunch(launches).id, '2');
    });
  });
}
