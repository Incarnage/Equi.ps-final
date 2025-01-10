import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/feature/personalize/controller/user_controller.dart';
import 'package:equips_v2/feature/personalize/screen/address/widgets/address_controller.dart';

import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/utilities/validator/validate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_places_flutter/google_places_flutter.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    final addressController = TextEditingController();
    
    

    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text(
          'My Address',
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: TSizes.defaultSpace, right: TSizes.defaultSpace,bottom: TSizes.defaultSpace, top: TSizes.defaultSpace/2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: controller.updateUserAddressFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      const Text("Current Address:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      const SizedBox(height: TSizes.spaceInputFields/2),

                       Obx(() => Text(
                          controller.user.value.address, 
                          
                          style: const TextStyle(fontSize: TSizes.fontMedium, fontWeight: FontWeight.normal)
                        )),
                
                    const SizedBox(height: TSizes.spaceInputFields),

                     GooglePlaceAutoCompleteTextField(
            
              textStyle: const TextStyle(fontSize: TSizes.fontMedium, fontWeight: FontWeight.normal),
              inputDecoration: const InputDecoration(
                labelText: "Address",
                prefixIcon: Icon(Iconsax.map),
              ),
              textEditingController: addressController,
              googleAPIKey: "AIzaSyBaYDvf3_TM58IsWhzKIKwaM58w31EEJSU",
              debounceTime: 800,
              countries: ["PH"], // Limit to the Philippines
              isLatLngRequired: true, // Get latitude & longitude
              getPlaceDetailWithLatLng: (prediction) {
                controller.latitude.value = double.parse(prediction.lat!);
                controller.longitude.value =  double.parse(prediction.lng!);
                controller.address.text = addressController.text;
              },
              itemClick: (prediction) {
                addressController.text = prediction.description!;
                controller.address.text = prediction.description!;
                controller.update();
              },
            ),

                  
                     const SizedBox(height: TSizes.spaceInputFields),
                    

                    // Sign Up Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          
                          controller.updateUserAddress();
                        },
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF25291C)),
                          backgroundColor: const Color(0xFF25291C),
                        ),
                        child: const Text('Update Address'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
