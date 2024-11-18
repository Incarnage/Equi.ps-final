import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class NotifInfo extends StatelessWidget {
  const NotifInfo({
    super.key,
    required this.title,
    required this.value,
  });

  final String title, value;
  @override
  Widget build(BuildContext context) {
    return Padding(
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
        ],
      ),
    );
  }
}
