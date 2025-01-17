import 'package:equips_v2/binding/gen_binding.dart';
import 'package:equips_v2/routes/app_routes.dart';
import 'package:equips_v2/utilities/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class to setup themes, initial bindings, any nominations and much more using material widget
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
       debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ETheme.lightTheme,
      initialBinding: GeneralBinding(),
      getPages: AppRoutes.pages,
      // show loader or circular progress indicator
      // auth repo decides whether to show relevant screens
      home: const Scaffold(
        backgroundColor: Color.fromARGB(255, 49, 49, 49),
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

