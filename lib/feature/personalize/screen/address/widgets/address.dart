import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/feature/personalize/screen/address/widgets/add_new_address.dart';
import 'package:equips_v2/feature/personalize/screen/address/widgets/single_address.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add button
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF25291C),
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(
          Iconsax.add,
          color: Colors.white,
        ),
      ),
      appBar: TAppbar(
        showBackArrow: false,
        title:
            Text("Addresses", style: Theme.of(context).textTheme.headlineSmall),
      ),

      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // selected address determines the highlighted box
              ESingleAddress(selectedAddress: false),
              ESingleAddress(selectedAddress: true),
            ],
          ),
        ),
      ),
    );
  }
}
