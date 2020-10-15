// GENERATED CODE - DO NOT MODIFY MANUALLY
// **************************************************************************
// Auto generated by https://github.com/fluttercandies/ff_annotation_route
// **************************************************************************

import 'package:ff_annotation_route/ff_annotation_route.dart';
import 'package:flutter/widgets.dart';

import 'ui/pages/bangumi_details_page.dart';
import 'ui/pages/home_page.dart';
import 'ui/pages/login_page.dart';
import 'ui/pages/splash_page.dart';

RouteResult getRouteResult({String name, Map<String, dynamic> arguments}) {
  arguments = arguments ?? const <String, dynamic>{};
  switch (name) {
    case 'mikan://bangumi-details':
      return RouteResult(
        name: name,
        widget: BangumiDetailsPage(
          key: arguments['key'] as Key,
          bangumiId: arguments['bangumiId'] as String,
          cover: arguments['cover'] as String,
        ),
        routeName: 'bangumi-details',
      );
    case 'mikan://home':
      return RouteResult(
        name: name,
        widget: HomePage(),
        routeName: 'mikan-home',
      );
    case 'mikan://login':
      return RouteResult(
        name: name,
        widget: LoginPage(),
        routeName: 'mikan-login',
      );
    case 'mikan://splash':
      return RouteResult(
        name: name,
        widget: SplashPage(),
        routeName: 'mikan-splash',
      );
    default:
      return const RouteResult(name: 'flutterCandies://notfound');
  }
}

class RouteResult {
  const RouteResult({
    @required this.name,
    this.widget,
    this.showStatusBar = true,
    this.routeName = '',
    this.pageRouteType,
    this.description = '',
    this.exts,
  });

  /// The name of the route (e.g., "/settings").
  ///
  /// If null, the route is anonymous.
  final String name;

  /// The Widget return base on route
  final Widget widget;

  /// Whether show this route with status bar.
  final bool showStatusBar;

  /// The route name to track page
  final String routeName;

  /// The type of page route
  final PageRouteType pageRouteType;

  /// The description of route
  final String description;

  /// The extend arguments
  final Map<String, dynamic> exts;
}
