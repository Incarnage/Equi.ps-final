import 'package:equips_v2/lessor/add_product/form/add_product_form.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class LessorAddProduct extends StatelessWidget {
  const LessorAddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text("Add Products",
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: TSizes.spaceSections),

            // Form
            const AddProductForm(),
          ],
        ),
      )),
    );
  }
}
