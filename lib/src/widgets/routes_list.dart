import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../theme/theme_notifier.dart';
import '../routes/routes.dart';

class RoutesList extends StatelessWidget {
  final bool navigate;
  final ThemeNotifier themeNotifier;
  final ValueNotifier<int> routeNotifier;

  const RoutesList({
    Key? key, this.navigate = true, 
    required this.themeNotifier,
    required this.routeNotifier
  }) : super(key: key);

  static const _routes = ThemeRoute.routes;

  void _navigate(BuildContext context, Widget widget){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return widget;
        },
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final secondaryColor = themeNotifier.value.data.colorScheme.secondary;

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) {
        return const Divider(color: Colors.grey, height: 3);
      },
      itemCount: _routes.length,
      itemBuilder: (context, index) {
        final route = _routes[index];

        return ListTile(
          leading: FaIcon(route.icon, color: secondaryColor),
          title: Text(route.title),
          trailing: FaIcon(FontAwesomeIcons.chevronRight, color: secondaryColor),
          onTap: () {
            if(navigate){
              _navigate(context, route.page);
            }
            
            routeNotifier.value = index;
          },
        );
      },
    );
  }
}