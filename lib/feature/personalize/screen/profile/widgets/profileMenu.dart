import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class profileMenu extends StatelessWidget {
  const profileMenu(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.value,
      this.icon});

  final IconData? icon;
  final VoidCallback onPressed;
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceItems / 1.5),
        child: Row(
          children: [
            // extract with widget > expanded
            // it will give enough space to all the 3 widgets
            Expanded(
              flex: 3,
              child: Text(title,
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis),
            ),
            Expanded(
              flex: 5,
              child: Text(value,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis),
            ),
            Expanded(child: Icon(icon)),
          ],
        ),
      ),
    );
  }
}
