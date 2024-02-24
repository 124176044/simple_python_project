import 'package:intl/intl.dart';

final format = DateFormat.yMd();

class Model {
  const Model({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.description,
  });

  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final String description;
}
