import 'package:equips_v2/app.dart';
import 'package:equips_v2/common/widgets/products%20cart/bookmark/bookmark_controller.dart';
import 'package:equips_v2/data/repository/authenticate_repository.dart';
import 'package:equips_v2/feature/auth/controller/signin/signin_controller.dart';
import 'package:equips_v2/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  //widget binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  //get local storage
  await GetStorage.init();

  //splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // initialize firebase and authentication repository
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticateRepository()));

  Get.lazyPut<BookmarkController>(() => BookmarkController());
  

  // Load all the material design / themes / localizations / bindings
  runApp(const App());
}
