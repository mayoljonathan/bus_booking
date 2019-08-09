part of '../custom_ui.dart';

class HeroDialogRoute<T> extends PageRoute<T> {
  HeroDialogRoute({ this.builder }) : super();

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  String get barrierLabel => null;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut
      ),
      child: child
    );
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation) {
    return builder(context);
  }

}

// class ScaleRoute extends PageRouteBuilder {

//   @override
//   bool get opaque => false;

//   @override
//   bool get barrierDismissible => true;

//   @override
//   Duration get transitionDuration => const Duration(milliseconds: 600);

//   @override
//   bool get maintainState => true;

//   @override
//   Color get barrierColor => Colors.black54;

//   @override
//   String get barrierLabel => null;

//   final Widget page;
//   ScaleRoute({this.page})
//       : super(
//           pageBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//           ) =>
//               page,
//           transitionsBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//             Widget child,
//           ) =>
//               ScaleTransition(
//                 scale: Tween<double>(
//                   begin: 0.0,
//                   end: 1.0,
//                 ).animate(
//                   CurvedAnimation(
//                     parent: animation,
//                     curve: Curves.easeInOutExpo,
//                   ),
//                 ),
//                 child: child,
//               ),
//         );
// }

class ScaleSizeRoute<T> extends PageRoute<T> {
  ScaleSizeRoute({ 
    @required this.builder,
    @required this.curve,
    this.duration = const Duration(milliseconds: 400)
  }) : super();

  final WidgetBuilder builder;
  final Curve curve;
  final Duration duration;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => duration;

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  String get barrierLabel => null;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: curve,
        ),
      ),
      child: Align(
        child: SizeTransition(
          sizeFactor: animation,
          child: child,
        ),
      )
    );
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation) {
    return builder(context);
  }

}