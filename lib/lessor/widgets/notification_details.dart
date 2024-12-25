import 'package:cached_network_image/cached_network_image.dart';
import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/common/widgets/custom_shapes/container/ERoundedContainer.dart';
import 'package:equips_v2/common/widgets/custom_shapes/container/eSectionHeading.dart';
import 'package:equips_v2/data/repository/user/user_repository.dart';
import 'package:equips_v2/feature/personalize/controller/user_controller.dart';
import 'package:equips_v2/feature/shop/order/widgets/order_controller.dart';
import 'package:equips_v2/feature/shop/order/widgets/order_model.dart';
import 'package:equips_v2/feature/shop/screen/product_reviews/review_lessors_product.dart';
import 'package:equips_v2/lessor/widgets/notif_detail_widget/notif_info.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.order});

  final OrderModel order;

  String formatDate(DateTime date) {
    return DateFormat('MMMM dd').format(date);
  }

  String formatTime(String time) {
    try {
      DateTime dateTime = DateFormat('HH:mm').parse(time);
      return DateFormat('hh:mm a').format(dateTime); // Format to 12-hour format with AM/PM
    } catch (e) {
      return time; // Return original time in case of error
    }
  }

  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository.instance;
    final orderController = OrderController.instance;

    // Initialize reactive order status
    final status = order.status.obs;

    return Scaffold(
      appBar: TAppbar(
        showBackArrow: false,
        title: Text(
          "Order Information",
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
            children: [
              const Divider(),
              const SizedBox(height: TSizes.spaceItems),
              const ESectionHeading(
                title: "Proof of Payment",
                showActionButton: false,
              ),

              // GCash proof of payment
              ERoundedcontainer(
                width: 180,
                height: 135,
                padding: const EdgeInsets.all(TSizes.small),
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () => showEnlargedImage(order.paymentImageUrl),
                      child: Center(
                        child: CachedNetworkImage(
                          imageUrl: order.paymentImageUrl,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              const Center(child: Icon(Icons.error)),
                          imageBuilder: (context, imageProvider) => ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceItems),
              const ESectionHeading(
                title: "Order Details",
                showActionButton: false,
              ),
              const SizedBox(height: TSizes.spaceItems),
              FutureBuilder<String>(
                future: userRepository.getLesseeName(order.lesseeId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return NotifInfo(title: 'Lessee Name', value: snapshot.data!);
                  } else {
                    return const Text('No lessee found');
                  }
                },
              ),
              const SizedBox(height: TSizes.spaceItems),
              NotifInfo(
                title: "FROM",
                value: formatDate(order.fromDate),
                type: 'date',
                time: formatTime(order.fromTime),
              ),
              const SizedBox(height: TSizes.spaceItems),
              NotifInfo(
                title: "TO",
                value: formatDate(order.toDate),
                type: 'date',
                time: formatTime(order.toTime),
              ),
              const SizedBox(height: TSizes.spaceItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceItems),

              // Buttons for Lessee and Lessor
              Obx(() {
  return Column(
    children: [
      if (UserController.instance.user.value.userType == "Lessee")
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (status.value == "Pending" || status.value == "Confirmed" || status.value == "Reviewed")
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF25291C)),
                      backgroundColor: const Color(0xFF25291C)),
                  onPressed: () => Get.back(),
                  child: const Text('Close'),
                ),
              ) 
            else if (status.value == "Returned")
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF25291C)),
                      backgroundColor: const Color(0xFF25291C)),
                  onPressed: (){
                    
                
                    Get.to(()=> RateLessorProduct(order: order));
                  },
                  child: const Text('Rate Product'),
                ),
              ),
          ],
        ),
      if (UserController.instance.user.value.userType == "Lessor")
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF25291C)),
                    backgroundColor: Colors.white),
                onPressed: () => Get.back(),
                child: const Text(
                  'Close',
                  style: TextStyle(color: Color(0xFF25291C)),
                ),
              ),
            ),
            const SizedBox(width: TSizes.spaceItems),
            if (status.value == "Pending")
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF25291C)),
                      backgroundColor: const Color(0xFF25291C)),
                  onPressed: () {
                    orderController.confirmOrder(order);
                    status.value = "Confirmed";
                     orderController.fetchAllLessorOrders();
                    Get.back();
                  },
                  child: const Text('Confirm'),
                ),
              )
            else if (status.value == "Confirmed")
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF25291C)),
                      backgroundColor: const Color(0xFF25291C)),
                  onPressed: () {
                    orderController.returnedProduct(order);
                    status.value = "Returned";
                    orderController.fetchAllLessorOrders();
                    Get.back();
                  },
                  child: const Text('Product Returned'),
                ),
              ),
          ],
        )
    ],
  );
}),

            ],
          ),
        ),
      ),
    );
  }

  void showEnlargedImage(String image) {
    Get.to(
      fullscreenDialog: true,
      () => Dialog.fullscreen(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: TSizes.defaultSpace * 2,
                  horizontal: TSizes.defaultSpace),
              child: CachedNetworkImage(imageUrl: image),
            ),
            const SizedBox(height: TSizes.spaceSections),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 150,
                child: OutlinedButton(
                    onPressed: () => Get.back(), child: const Text('Close')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
