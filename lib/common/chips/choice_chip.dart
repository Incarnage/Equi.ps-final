import 'package:equips_v2/common/widgets/custom_shapes/container/circle.dart';
import 'package:equips_v2/utilities/helper/helper.dart';
import 'package:flutter/material.dart';

class EChoiceChip extends StatelessWidget {
  const EChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = EHelperFunctions.getColor(text) != null;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor ? SizedBox() : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? Colors.white : null),
        avatar: isColor
            ? CircularContainer(
                backgroundColor: EHelperFunctions.getColor(text)!,
                width: 50,
                height: 50,
              )
            : null,
        shape: isColor ? CircleBorder() : null,
        labelPadding: isColor ? EdgeInsets.all(0) : null,
        padding: isColor ? EdgeInsets.all(0) : null,
        backgroundColor: isColor ? EHelperFunctions.getColor(text)! : null,
      ),
    );
  }
}
