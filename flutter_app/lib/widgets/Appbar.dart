import 'package:flutter/material.dart';

class Appbar extends StatelessWidget  implements PreferredSizeWidget {
  final Widget title;
  final Widget? leading;
  final List<Widget>? actions;
  const Appbar({super.key, required this.title, this.actions, this.leading});
@override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      actions: actions,
      backgroundColor: Theme.of(context).primaryColor,
          iconTheme: Theme.of(context).iconTheme,
      leading: leading
    );
  }
}