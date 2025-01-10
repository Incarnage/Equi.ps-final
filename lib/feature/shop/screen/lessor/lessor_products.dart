import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/common/widgets/brands/lessor_card.dart';
import 'package:equips_v2/common/widgets/products/scroll/sortable_product.dart';
import 'package:equips_v2/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:equips_v2/feature/auth/controller/signUp/widgets/usermodel.dart';
import 'package:equips_v2/feature/shop/controller/lessor_controller.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/utilities/helper/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

class LessorProducts extends StatelessWidget {
  const LessorProducts({super.key, required this.lessor});

  final UserModel lessor;

  @override
  Widget build(BuildContext context) {
    final controller = LessorController.instance;
    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text(
          lessor.fullName,
          style: const TextStyle(color: Color(0xFF25291C)),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //brand detail

              /* ELessorCard(
                showBorder: true,
                lessor: lessor,
              ),
              const SizedBox(
                height: TSizes.spaceSections,
              ),*/
              FutureBuilder(
                  future: controller.getLessorProducts(lessorId: lessor.id),
                  builder: (context, snapshot) {
                    const loader = EVerticalProductShimmer();
                    final widget = ECloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);

                    if (widget != null) return widget;

                    final lessorProducts = snapshot.data!;
                    return SortableProduct(
                      products: lessorProducts,
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
