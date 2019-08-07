part of '../custom_ui.dart';

class CustomSliverBody extends StatelessWidget {
  const CustomSliverBody({
    this.controller,
    this.expandedHeight = 140,
    this.leading,
    this.title,
    this.background,
    this.collapseMode = CollapseMode.parallax,
    this.bottomSize = kToolbarHeight / 1.2,
    @required this.slivers,
    this.extraLayer
  });

  final ScrollController controller;
  final Widget leading;
  final double expandedHeight;
  final Widget title;

  /// Background widget of the flexibleSpaceBar
  final Widget background;
  final CollapseMode collapseMode;

  final double bottomSize;

  /// Typically a list of slivers [SliverFillRemaining], [SliverFillViewPort], [SliverList]
  final List<Widget> slivers;

  /// Stacks with the body
  final Widget extraLayer;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomScrollView(
          // physics: BouncingScrollPhysics(),
          controller: controller,
          slivers: <Widget>[
            SliverAppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24.0),
                  bottomRight: Radius.circular(24.0),
                ),
              ),
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              leading: _buildLeading(context),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(bottomSize),
                child: Container(),
              ),
              pinned: true,
              expandedHeight: expandedHeight,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsetsDirectional.only(start: 24, bottom: 16.0),
                title: title,
                background: background,
                collapseMode: collapseMode,
              ),
            ),
            ...slivers
          ],
        ),
        if (extraLayer != null) extraLayer
      ],
    );
  }

  Widget _buildLeading(context) {
    Widget _widget = leading;

    if (leading == null) {
      _widget = IconButton(
        icon: Icon(EvaIcons.arrowBack),
        onPressed: () => Navigator.pop(context),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: _widget
    );
    // return Padding(
    //   padding: const EdgeInsets.only(left: 12.0, top: 12.0),
    //   child: _widget
    // );
  }
}