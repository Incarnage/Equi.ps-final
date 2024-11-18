import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(showBackArrow: true, title: Text("Add a new address")),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.user), labelText: "Name")),
                  const SizedBox(height: TSizes.spaceInputFields),
                  TextFormField(
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.mobile),
                          labelText: "Phone Number")),
                  const SizedBox(height: TSizes.spaceInputFields),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.building_31),
                                labelText: "Street")),
                      ),
                      const SizedBox(width: TSizes.spaceInputFields),
                      Expanded(
                        child: TextFormField(
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.code),
                                labelText: "Postal Code")),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceInputFields),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.building),
                                labelText: "City")),
                      ),
                      const SizedBox(width: TSizes.spaceInputFields),
                      Expanded(
                        child: TextFormField(
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.activity),
                                labelText: "State")),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceInputFields),
                  TextFormField(
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.global),
                          labelText: "Country")),
                  const SizedBox(height: TSizes.defaultSpace),
                  SizedBox(
                      width: double.infinity,
                      child:
                          ElevatedButton(onPressed: () {}, child: Text("Save")))
                ],
              ),
            )),
      ),
    );
  }
}
