import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TAppbar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Home AppBar Title",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: Colors.grey)),
          Text("Home AppBar subTitle",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: Colors.white)),
        ],
      ),
    );
  }
}
