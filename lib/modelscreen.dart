import 'package:flutter/material.dart';
import 'package:sample_application/model_bp2.dart';
import 'package:sample_application/modelitem.dart';

class Modelscreen extends StatelessWidget {
  const Modelscreen(
      {super.key,
      required this.models,
      required this.cate,
      required this.onto});
  final List<Model> models;
  final String cate;
  final void Function(Model meal) onto;
  @override
  Widget build(context) {
    Widget content = ListView.builder(
        itemCount: models.length,
        itemBuilder: (ctx, index) => Modelitem(
              model1: models[index],
              onto: onto,
            ));

    if (models.isEmpty) {
      return Center(
        child: Text(
          'UH..nothing is here please add models',
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      );
    }

    if (models.isNotEmpty) {
      return content;
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'GO BACK',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: content);
  }
}
