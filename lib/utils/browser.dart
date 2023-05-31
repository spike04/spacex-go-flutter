import 'package:cherry/cubits/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:url_launcher/url_launcher.dart';

extension OpenURL on BuildContext {
  Future<dynamic> openUrl(String url) async {
    if (read<BrowserCubit>().browserType == BrowserType.inApp) {
      return FlutterWebBrowser.openWebPage(
        url: url,
        customTabsOptions: CustomTabsOptions(
          instantAppsEnabled: true,
          showTitle: true,
        ),
      );
    } else {
      if (!await launchUrl(Uri.parse(url))) {
        throw Exception('Could not launch $url');
      }
    }
  }
}
