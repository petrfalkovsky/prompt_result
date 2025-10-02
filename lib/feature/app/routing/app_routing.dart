import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prompt_result/feature/app/routing/path_route.dart';

class _ImageCacheManager extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    debugPrint(
      "[!IMPORTANT!] Pushed to ${_returnRouteInfo(route)} from: ${_returnRouteInfo(previousRoute)}",
    );
    PaintingBinding.instance.imageCache.clear();
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    debugPrint(
      "[!IMPORTANT!] Popped to ${_returnRouteInfo(route)} from: ${_returnRouteInfo(previousRoute)}",
    );
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  }

  String _returnRouteInfo(Route? route) {
    var settings = route?.settings;
    var result = "";
    if (route != null && route.runtimeType.toString().contains('_CustomTransitionPageRoute')) {
      if (settings is CustomTransitionPage) {
        final child = settings.child;
        result += "(${child.runtimeType})";
      }
    }
    return result;
  }
}

final rootNavigatorKey = GlobalKey<NavigatorState>();

// global current context getter
BuildContext? get rootCurrentContext {
  final context = rootNavigatorKey.currentState?.context;
  return context;
}

final goRouter = GoRouter(
  observers: [_ImageCacheManager()],
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoute.init,
  routes: [
    // GoRoute(
    //   path: AppRoute.init,
    //   name: AppRoute.init,
    //   pageBuilder: (context, state) {
    //     return CustomTransitionPage(
    //       key: state.pageKey,
    //       child: const LauncherScreen(),
    //       transitionsBuilder: _transitionsBuilder,
    //     );
    //   },
    //   routes: const [],
    // ),
  ],
  errorBuilder: ((context, state) => Container()),
);

Widget _transitionsBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final isReverse = secondaryAnimation.status == AnimationStatus.reverse;

  var scaleAnimation = Tween<double>(
    begin: isReverse ? 1.0 : 1.5,
    end: isReverse ? 1.5 : 1.0,
  ).chain(CurveTween(curve: Curves.ease)).animate(isReverse ? secondaryAnimation : animation);

  var fadeAnimation = Tween<double>(
    begin: isReverse ? 1.0 : 0.0,
    end: isReverse ? 0.0 : 1.0,
  ).chain(CurveTween(curve: Curves.ease)).animate(isReverse ? secondaryAnimation : animation);

  return FadeTransition(
    opacity: fadeAnimation,
    child: ScaleTransition(scale: scaleAnimation, child: child),
  );
}

Page _customTransitionPage({required GoRouterState state, required Widget child}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    reverseTransitionDuration: const Duration(milliseconds: 1000),
    transitionDuration: const Duration(milliseconds: 1000),
    transitionsBuilder: _transitionsBuilder,
  );
}
