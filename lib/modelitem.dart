import 'package:flutter/material.dart';
import 'package:sample_application/model_bp2.dart';
import 'package:sample_application/modeldetails.dart';
import 'package:transparent_image/transparent_image.dart';

class Modelitem extends StatelessWidget {
  const Modelitem({super.key, required this.model1, required this.onto});

  final Model model1;
  final void Function(Model model2) onto;

  @override
  Widget build(context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => Modeldetail(
                    model2: model1,
                    ontoggle: onto,
                  )));
        },
        splashColor: Colors.orange,
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(
                model1.imageUrl,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      model1.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
