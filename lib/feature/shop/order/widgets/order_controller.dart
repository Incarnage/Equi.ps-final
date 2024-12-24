import 'dart:io';

import 'package:equips_v2/common/widgets/order_sucess.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/feature/shop/order/widgets/order_model.dart';
import 'package:equips_v2/feature/shop/order/widgets/order_repository.dart';
import 'package:equips_v2/lessor/lessor_Navigation_menu.dart';
import 'package:equips_v2/navigation_menu.dart';
import 'package:equips_v2/utilities/network/network_manager.dart';
import 'package:equips_v2/utilities/popups/full_screen_loader.dart';
import 'package:equips_v2/utilities/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  // Variables

  final fromDate = TextEditingController();
  final toDate = TextEditingController();
  final fromTime = TextEditingController();
  final toTime = TextEditingController();
  final isLoading = false.obs;
  final orderRepository = OrderRepository.instance;

  Rx<XFile?> imageFile = Rx<XFile?>(null);
  RxList<OrderModel> orders = <OrderModel>[].obs;

  void setImageFile(XFile? file) {
    imageFile.value = file;
  }

  GlobalKey<FormState> orderFormKey = GlobalKey<FormState>();

  Future<String?> uploadImageToStorage(XFile imageFile) async {
    try {
      final db = FirebaseStorage.instance.ref();
      final image = db.child('payments/${imageFile.name}');
      await image.putFile(File(imageFile.path));
      return await image.getDownloadURL();
    } catch (e) {
      ELoaders.errorSnackBar(title: "Upload Error", message: e.toString());
      return null;
    }
  }

  void pay(ProductModel product) async {
    try {
      // Start Loading
      EFullScreenLoader.openLoadingDialog(
          "We are processing your order...", "assets/pic/loading.json");
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        EFullScreenLoader.stopLoading();
        return;
      }

      if (!orderFormKey.currentState!.validate()) {
        return;
      }

      DateTime? fromdate;
      DateTime? todate;
      TimeOfDay? fromtime;
      TimeOfDay? totime;

      try {
        fromdate = DateFormat('yyyy-MM-dd').parse(fromDate.text.trim());
        todate = DateFormat('yyyy-MM-dd').parse(toDate.text.trim());

       fromtime = _parseTime(fromTime.text);
      totime = _parseTime(toTime.text);
      } catch (e) {
        ELoaders.errorSnackBar(
            title: "Invalid Date Format",
            message: "Please enter dates in the correct format.");
        return;
      }

     


      if (todate.isBefore(fromdate) ||
          (todate.isAtSameMomentAs(fromdate) &&
              (totime!.hour < fromtime!.hour ||
                  (totime.hour == fromtime.hour &&
                      totime.minute <= fromtime.minute)))) {
        ELoaders.errorSnackBar(
            title: "Invalid Date/Time Range",
            message: "The end date and time must be after the start.");
        return;
      }

      final uploadImage = await uploadImageToStorage(imageFile.value!);
      if (uploadImage == null) {
        return;
      }

      // Save order data in the Firebase Firestore
      final newOrder = OrderModel(
          status: "Pending",
          lessorId: product.lessor!.id,
          lesseeId: FirebaseAuth.instance.currentUser!.uid,
          productId: product.id,
          paymentImageUrl: uploadImage,
          fromDate: fromdate,
          toDate: todate,
          fromTime: "${fromtime!.hour}:${fromtime.minute}",
          toTime:"${totime!.hour}:${totime.minute}",
          );

      final orderRepository = Get.put(OrderRepository());
      await orderRepository.saveOrderRecord(newOrder);
      // Show Success Message

      ELoaders.successSnackBar(
          title: 'Congrats', message: 'Order has been placed');
      Get.off(() => const NavigationMenu());
      EFullScreenLoader.stopLoading();
    } catch (e) {
      // Show some generic error to the user
      ELoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      // Remove Loader
      EFullScreenLoader.stopLoading();
      Get.off(() => const OrderSucess());
    }
  }

  TimeOfDay _parseTime(String time) {
  try {
    // Parse the 12-hour format time (hh:mm a)
    final parsedTime = DateFormat('hh:mm a').parse(time);
    return TimeOfDay(hour: parsedTime.hour, minute: parsedTime.minute);
  } catch (e) {
    throw FormatException("Invalid time format");
  }
}

  Future<void> fetchAllLessorOrders() async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading.value = true;
      });

      final order = await orderRepository.getLessorsOrders();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        orders.assignAll(order);
        isLoading.value = false;
      });
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading.value = false;
        ELoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      });
    }
  }

  Future<void> fetchAllLesseeOrders() async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading.value = true;
      });

      final order = await orderRepository.getLesseesOrders();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        orders.assignAll(order);
        isLoading.value = false;
      });
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading.value = false;
        ELoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      });
    }
  }

  Future<void> confirmOrder(OrderModel order) async {
    try {
      EFullScreenLoader.openLoadingDialog(
          "Confirming your order", "assets/pic/loading.json");

      // Update order status in Firestore
      final success =
          await orderRepository.updateOrderStatus(order.id!, 'Confirmed');

      await orderRepository.updateProductStatus(
        order.productId,
      );
      if (success) {
        ELoaders.successSnackBar(
            title: 'Success', message: 'Order has been confirmed');
      } else {
        ELoaders.errorSnackBar(
            title: 'Error', message: 'Failed to confirm order');
      }
    } catch (e) {
      ELoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      EFullScreenLoader.stopLoading();
      Get.off(() => const LessorNavigationMenu());
    }
  }

  Future<void> returnedProduct(OrderModel order) async {
    try {
      // Update order status in Firestore
      await orderRepository.updateProductStatus(
        order.productId,
      );

      ELoaders.successSnackBar(
          title: 'Success', message: 'Product has been returned');
    } catch (e) {
      ELoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      EFullScreenLoader.stopLoading();
      Get.off(() => const LessorNavigationMenu());
    }
  }
}
