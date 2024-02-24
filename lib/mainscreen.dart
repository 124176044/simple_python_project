import 'package:flutter/material.dart';
import 'package:sample_application/models_bp.dart';
import 'package:sample_application/model_bp3.dart';
import 'package:sample_application/model_bp2.dart';
import 'package:sample_application/modelscreen.dart';
import 'package:sample_application/screenstyle.dart';

class mainscreen extends StatelessWidget {
  mainscreen({super.key, required this.ontoo});

  final void Function(Model model) ontoo;

  void selectcategory(BuildContext context, Model_bp category) {
    final filteredModels = dummyModels
        .where((model) => model.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Modelscreen(
          models: filteredModels,
          cate: category.title,
          onto: ontoo,
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick your Models'),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 5 / 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 10),
        children: [
          for (final category in availablemodels)
            gridscreen(
              category: category,
              select: () {
                selectcategory(context, category);
              },
            )
        ],
      ),
    );
  }
}
