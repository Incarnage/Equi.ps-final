import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/common/widgets/brands/lessor_card.dart';
import 'package:equips_v2/common/widgets/layouts/gridLayout.dart';
import 'package:equips_v2/common/widgets/shimmer/lessor_shimmer.dart';
import 'package:equips_v2/common/widgets/text/section_heading.dart';
import 'package:equips_v2/feature/shop/controller/lessor_controller.dart';
import 'package:equips_v2/feature/shop/screen/lessor/lessor_products.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllLessors extends StatelessWidget {
  const AllLessors({super.key});

  @override
  Widget build(BuildContext context) {
    final lessorController = LessorController.instance;
    return Scaffold(
      appBar: const TAppbar(
        title: Text('Lessors'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //heading

              const SectionHeading(
                title: 'Lessors',
                buttonTitle: '',
              ),
              const SizedBox(
                height: TSizes.spaceItems,
              ),

              //brands

              Obx(() {
                if (lessorController.isLoading.value) {
                  return const LessorShimmer();
                }

                if (lessorController.allLessors.isEmpty) {
                  return const Center(
                    child: Text('No Data Found'),
                  );
                }
                return EGridLayout(
                    itemCount: lessorController
                        .allLessors.length, // number of elements / products
                    mainAxisExtent:
                        80, // it's like teh length downwards of each element
                    itemBuilder: (_, index) {
                      final lessor = lessorController.allLessors[index];
                      return ELessorCard(
                        onTap: () => Get.to(() => LessorProducts(
                              lessor: lessor,
                            )),
                        showBorder: true,
                        lessor: lessor,
                      );
                    });
              })
            ],
          ),
        ),
      ),
    );
  }
}
