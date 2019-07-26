part of '../custom_ui.dart';

class RoundedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final EdgeInsetsGeometry padding;
  final double height;
  final bool automaticallyImplyLeading;
  final Widget leading;
  final Widget title;

  const RoundedAppBar({
    Key key,
    this.automaticallyImplyLeading = true,
    this.leading,
    this.title,
    this.padding,
    this.height = 75,
  });

  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.white,
        elevation: 4.0,
        shadowColor: Colors.grey[100],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.0),
          bottomRight: Radius.circular(24.0),
        ),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: padding != null
            ? padding
            : EdgeInsets.symmetric(horizontal: 11.0),
          child: Row(
            children: <Widget>[
              _buildLeadingIcon(context),
              SizedBox(width: 6.0),
              if (title != null) title
            ],
          ),
        )
      ),
    );
  }

  Widget _buildLeadingIcon(BuildContext context) {
    if (leading != null) return leading;
    if (automaticallyImplyLeading) {
      return IconButton(
        icon: Icon(EvaIcons.arrowBack),
        onPressed: () => Navigator.of(context).pop(),
      );
    }

    return Container();
  }
}
