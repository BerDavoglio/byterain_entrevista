import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Theme.of(context).primaryColor,
      leadingWidth: 80,
      toolbarHeight: 100,
      centerTitle: true,
      title: Text(
        'Contacts',
        style: TextStyle(
          fontSize: 40,
        ),
      ),
    );
  }
}
