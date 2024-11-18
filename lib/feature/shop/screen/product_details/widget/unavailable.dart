import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class Unavailable extends StatelessWidget {
  const Unavailable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(TSizes.cardRaidusLarge),
              topRight: Radius.circular(TSizes.cardRaidusLarge))),
      child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25291C)),
              onPressed: null,
              child: const Text(
                'Unavailable',
                style: TextStyle(color: Color(0xFF25291C)),
              ))),
    );
  }
}
