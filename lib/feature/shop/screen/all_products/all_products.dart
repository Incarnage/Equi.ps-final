import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/common/widgets/products/scroll/sortable_product.dart';
import 'package:equips_v2/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:equips_v2/feature/shop/controller/all_product_controller.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/utilities/helper/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProducts extends StatelessWidget {
  const AllProducts(
      {super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    return Scaffold(
      appBar: TAppbar(
        title: Text(title),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchProductsbyQuery(query),
            builder: (context, snapshot) {
              const loader = EVerticalProductShimmer();

              final widget = ECloudHelperFunctions.checkMultiRecordState(
                snapshot: snapshot,
                loader: loader,
              );

              if (widget != null) return widget;

              final products = snapshot.data!;

              return SortableProduct(
                products: products,
              );
            },
          ),
        ),
      ),
    );
  }
}
