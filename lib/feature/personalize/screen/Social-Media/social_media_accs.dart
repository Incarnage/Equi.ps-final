import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/feature/personalize/screen/Social-Media/socmed_controller.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/utilities/validator/validate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialMediaAccs extends StatelessWidget {
  const SocialMediaAccs({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SocmedController());

    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text(
          'Your Social Details',
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add other communication channels.',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                'Please provide your social media account links.',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                    fontSize: TSizes.fontMedium,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromARGB(255, 99, 97, 97)),
              ),
              const SizedBox(
                height: TSizes.spaceSections,
              ),
              Form(
                  key: controller.updateUserNameFormKey,
                  child: Column(
                    children: [
                      // Facebook
                      TextFormField(
                        style: const TextStyle(
                            fontSize: TSizes.fontMedium,
                            fontWeight: FontWeight.normal),
                        controller: controller.facebook,
                        
                        expands: false,
                        decoration: InputDecoration(
                            labelText: 'Facebook',
                            prefixIcon: Image.asset('assets/logo/facebook.png',
                                width: 48, height: 28)),
                      ),
                      const SizedBox(
                        height: TSizes.spaceItems,
                      ),

                      // Instagram
                      TextFormField(
                        style: const TextStyle(
                            fontSize: TSizes.fontMedium,
                            fontWeight: FontWeight.normal),
                        controller: controller.instagram,
                      

                        expands: false,
                        decoration: InputDecoration(
                            labelText: 'Instagram',
                            prefixIcon: Image.asset('assets/logo/instagram.png',
                                width: 28, height: 28)),
                      ),
                      const SizedBox(
                        height: TSizes.spaceItems,
                      ),

                      // Gmail
                      TextFormField(
                        style: const TextStyle(
                            fontSize: TSizes.fontMedium,
                            fontWeight: FontWeight.normal),
                        controller: controller.gmail,
                       
                        expands: false,
                        decoration: InputDecoration(
                            labelText: 'Gmail',
                            prefixIcon: Image.asset('assets/logo/gmail.png',
                                width: 28, height: 28)),
                      )
                    ],
                  )),
              const SizedBox(
                height: TSizes.spaceSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF25291C),
                        side: const BorderSide(color: Color(0xFF25291C))),
                    onPressed: () => controller.updateUserName(),
                    child: const Text('Save')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
