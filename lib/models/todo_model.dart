import 'package:uuid/uuid.dart';

var _uuid = const Uuid();

class TodoModel {
  TodoModel({
    String? id,
    this.description,
    this.isCompleted = false,
  }) : id = id ?? _uuid.v4();

  final String id;
  final String? description;
  final bool isCompleted;
}
