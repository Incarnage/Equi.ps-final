import 'package:equips_v2/utilities/device/device_util.dart';
import 'package:flutter/material.dart';

class ETabBar extends StatelessWidget implements PreferredSizeWidget {
  const ETabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: const Color(0xFF25291C),
        labelColor: const Color(0xFF25291C),
        unselectedLabelColor: const Color.fromARGB(255, 173, 173, 173),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(EDeviceUtils.getAppBarHeight());
}
