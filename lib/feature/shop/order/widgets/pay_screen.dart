import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equips_v2/common/images/e_circular_image.dart';
import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/common/widgets/custom_shapes/container/eSectionHeading.dart';
import 'package:equips_v2/feature/auth/screen/home/widget/shimmer.dart';
import 'package:equips_v2/feature/personalize/controller/user_controller.dart';
import 'package:equips_v2/feature/shop/controller/product/images_controller.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/feature/shop/order/widgets/order_controller.dart';
import 'package:equips_v2/feature/shop/order/widgets/order_date_picker.dart';
import 'package:equips_v2/feature/shop/order/widgets/order_info.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/utilities/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PayScreen extends StatelessWidget {
  PayScreen({super.key, required this.product});

  final ProductModel product;
  final ImagePicker _picker = ImagePicker();
  Rx<XFile?> imageFile = Rx<XFile?>(null);

  final RxString lessorGcashPhoto = "".obs;

  @override
  Widget build(BuildContext context) {

    Get.put(OrderController());
    final controller = UserController.instance;
    final ordercontroller = OrderController.instance;
    fetchLessorGcashPhoto(product.lessor!.id);
    double partialPrice = product.price / 2;
    return Form(
        key: ordercontroller.orderFormKey,
        child: Scaffold(
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: TSizes.defaultSpace,
                vertical: TSizes.defaultSpace / 2),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(TSizes.cardRaidusLarge),
                    topRight: Radius.circular(TSizes.cardRaidusLarge))),
            child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF25291C)),
                        backgroundColor: const Color(0xFF25291C)),
                    onPressed: () {
                      if (ordercontroller.orderFormKey.currentState!
                          .validate()) {
                        ordercontroller.pay(product);
                      } else {
                        ELoaders.errorSnackBar(
                            title: "Oh Snap!",
                            message: 'Please fill all required fields.');
                      }
                    },
                    child: const Text('Pay'))),
          ),
          appBar: const TAppbar(showBackArrow: true, title: Text("Payment")),

          // BODY
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        ESectionHeading(
                            title: "Rental Date",
                            showActionButton: false,
                            onPressed: () {}),
                        const SizedBox(height: TSizes.spaceItems),
                        SelectDate(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a start date';
                            }
                            return null;
                          },
                          controller: ordercontroller.fromDate,
                          title: "From",
                        ),
                        const SizedBox(height: TSizes.spaceItems),
                        SelectDate(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a start date';
                            }
                            return null;
                          },
                          controller: ordercontroller.toDate,
                          title: "Until",
                        ),
                        const SizedBox(height: TSizes.spaceItems),
                        const Divider(),
                        const SizedBox(height: TSizes.spaceItems),
                        Obx(() {
  final networkImage = lessorGcashPhoto.value;
  final image = (networkImage.isNotEmpty)
      ? networkImage
      : 'assets/pic/profile-icon.png';

  return controller.imageUploading.value
      ? const ShimmerEffect(
          width: 80,
          height: 80,
          radius: 80,
        )
      : GestureDetector(
          onTap: () {
            if (networkImage.isNotEmpty) {
              ImagesController.instance.showEnlargedImage(networkImage);
            } else {
              ELoaders.errorSnackBar(
                title: 'Error',
                message: 'No image available to enlarge',
              );
            }
          },
          child: ECircularImage(
            image: image,
            width: 500,
            height: 400,
            isNetworkImage: networkImage.isNotEmpty,
          ),
        );
})
,
                        SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              product.lessor!.name,
                              style:
                                  const TextStyle(fontSize: TSizes.fontLarge),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  // Details
                  const SizedBox(height: TSizes.spaceItems / 2),
                  const Divider(),
                  const SizedBox(height: TSizes.spaceItems),

                  // Heading Profile Info
                  const ESectionHeading(
                    title: "Payment Option",
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceItems),

                  OrderInfo(
                    title: "Full",
                    value: product.price.toString(),
                  ),
                  OrderInfo(
                    title: "Partial",
                    value: partialPrice.toString(),
                  ),

                  const SizedBox(height: TSizes.spaceItems),
                  const Divider(),
                  const SizedBox(height: TSizes.spaceItems),

                  // Heading Personal Info
                  ESectionHeading(
                      title: "Proof of Payment",
                      showActionButton: false,
                      onPressed: () {}),
                  const SizedBox(height: TSizes.spaceItems),

                  TextButton(
                    onPressed: () async {
                      // Pick the image and pass it to the controller
                      final pickedFile =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        ordercontroller.setImageFile(
                            pickedFile); // Set the picked image in the controller
                      } else {
                        ELoaders.errorSnackBar(
                            title: 'Error', message: 'No image selected');
                      }
                    },
                    child: const Text(
                      "Upload Proof of Payment",
                      style: TextStyle(color: Color(0xFF25291C)),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceItems),

                  // Display the selected image
                  Obx(() {
                    if (ordercontroller.imageFile.value != null) {
                      return Image.file(
                        File(ordercontroller.imageFile.value!.path),
                        height: 100,
                      );
                    } else {
                      return const Text("No image selected.");
                    }
                  }),

                  const Divider(),
                ],
              ),
            ),
          ),
        ));
  }

  void fetchLessorGcashPhoto(String lessorId) async {
    try {
      // Fetch the lessor's user data from Firestore
      DocumentSnapshot<Map<String, dynamic>> lessorDoc = await FirebaseFirestore
          .instance
          .collection('Users')
          .doc(lessorId)
          .get();

      if (lessorDoc.exists) {
        final lessorData = lessorDoc.data();
        lessorGcashPhoto.value = lessorData?['Gcash'] ?? '';
      } else {
        ELoaders.errorSnackBar(title: 'Error', message: 'Lessor not found');
      }
    } catch (e) {
      ELoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
