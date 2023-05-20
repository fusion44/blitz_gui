import 'package:flutter/material.dart';

const headerBarIconSize = 25.0;

enum RouteNames { home, sseTester }

List<NavigationRailDestination> getNavRailDestinations() {
  return const [
    NavigationRailDestination(
      icon: Icon(Icons.handyman_rounded),
      label: Text('Machine Room'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.list),
      label: Text('SSE Inspector'),
    ),
  ];
}
