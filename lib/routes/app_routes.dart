import 'package:equips_v2/feature/auth/screen/home/home.dart';
import 'package:equips_v2/feature/auth/screen/signin/widgets/form.dart';
import 'package:equips_v2/feature/auth/screen/signup/Lessee/sign_up_lessee.dart';
import 'package:equips_v2/feature/auth/screen/signup/Lessee/verify_email.dart';
import 'package:equips_v2/feature/personalize/screen/address/widgets/address.dart';
import 'package:equips_v2/feature/personalize/screen/profile/profile.dart';
import 'package:equips_v2/feature/personalize/screen/settings/settings.dart';
import 'package:equips_v2/feature/shop/screen/cart/cart.dart';
import 'package:equips_v2/feature/shop/screen/checkout/checkout.dart';
import 'package:equips_v2/feature/shop/screen/order/order.dart';
import 'package:equips_v2/feature/shop/screen/product_reviews/productReviews.dart';
import 'package:equips_v2/feature/shop/screen/store/store.dart';
import 'package:equips_v2/routes/routes.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: ERoutes.home, page: () => const HomeScreen()),
    GetPage(name: ERoutes.store, page: () => const Store()),
    GetPage(name: ERoutes.settings, page: () => const SettingScreen()),
    GetPage(
        name: ERoutes.productReviews, page: () => const ProductReviewScreen()),
    GetPage(name: ERoutes.order, page: () => const OrderScreen()),
    GetPage(name: ERoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: ERoutes.cart, page: () => const CartScreen()),
    GetPage(name: ERoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: ERoutes.userAddress, page: () => const UserAddressScreen()),
    GetPage(name: ERoutes.signUpLessee, page: () => const SignUpLessee()),
    GetPage(name: ERoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: ERoutes.signIn, page: () => const SignIn_Form()),
  ];
}
