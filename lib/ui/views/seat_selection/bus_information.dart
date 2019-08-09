import 'package:bus_booking/core/models/bus.dart';
import 'package:bus_booking/ui/shared/theme.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:slide_container/slide_container.dart';
import 'package:slide_container/slide_container_controller.dart';

class BusInformation extends StatefulWidget {
  const BusInformation({
    Key key,
    this.busSchedule,
  });

  final BusSchedule busSchedule;

  @override
  _BusInformationState createState() => _BusInformationState();
}

class _BusInformationState extends State<BusInformation> {

  final SlideContainerController slideController = SlideContainerController();
  final ScrollController scrollController = ScrollController();
  double get maxSlideDistance => MediaQuery.of(context).size.height;
  ScrollPosition get scrollPosition => scrollController.position;
  bool get isAtMinScrollPosition => scrollController.offset <= scrollPosition.minScrollExtent;
  bool get isAtMaxScrollPosition => scrollController.offset >= scrollPosition.maxScrollExtent;
  double position = 0.0;
  bool stoppedScrollingAtMinScrollPosition = true;
  bool stoppedScrollingAtMaxScrollPosition = false;

  double _opacity = 0;

  @override
  void dispose() {
    scrollController?.dispose();
    slideController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 400), () {
      if (!mounted) return;
      setState(() => _opacity = 1);
    });
  }

  void onSlide(double position) => setState(() => this.position = position);
  void onSlideCompleted() => Navigator.pop(context);

  bool onScrollNotification(ScrollNotification scrollNotification) {
    if (scrollNotification is ScrollEndNotification) {
      stoppedScrollingAtMinScrollPosition = isAtMinScrollPosition;
      stoppedScrollingAtMaxScrollPosition = isAtMaxScrollPosition;
      print(stoppedScrollingAtMinScrollPosition
          ? "Stopped at top"
          : stoppedScrollingAtMaxScrollPosition ? "Stopped at bottom" : "Not stopped at extremity");
    }
    if (scrollNotification is OverscrollNotification) {
      if (scrollNotification.overscroll < 0 && stoppedScrollingAtMinScrollPosition) {
        slideController.forceSlide(SlideContainerDirection.topToBottom);
      }
      if (scrollNotification.overscroll > 0 && stoppedScrollingAtMaxScrollPosition) {
        slideController.forceSlide(SlideContainerDirection.bottomToTop);
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) => SlideContainer(
    controller: slideController,
    slideDirection: SlideContainerDirection.vertical,
    autoSlideDuration: Duration(milliseconds: 300),
    maxSlideDistance: maxSlideDistance,
    onSlide: onSlide,
    onSlideCompleted: onSlideCompleted,
    child: NotificationListener<ScrollNotification>(
      onNotification: onScrollNotification,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          color: Colors.white,
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //     colors: [
          //       Color.lerp(Color(0xfffddb92), Color(0xfffed6e3), position),
          //       Color.lerp(Color(0xffd1fdff), Color(0xff9a9ce2), position),
          //     ],
          //   ),
          // ),
          child: _buildBody()
        ),
      ),
    ),
  );

  Widget _buildBody() {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: SafeArea(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(milliseconds: 600),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24.0, 12.0, 12.0, 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(widget.busSchedule.bus.company.name, style: textTheme.headline.copyWith(
                        fontWeight: FontWeight.bold
                      )),
                    ),
                    IconButton(
                      icon: Icon(EvaIcons.collapseOutline, color: kAccentColor),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: _buildContent()
                  ),
                )
              ],
            )
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Container();
  }

}