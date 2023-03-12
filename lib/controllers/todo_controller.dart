import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rhitmo_list/controllers/database_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/todo.dart';

class TodoController extends GetxController {
  var textTodo = ''.obs;
  var timeClicked = false.obs;
  var timeTodo = TimeOfDay.now().obs;
  var isImportant = false.obs;
  var imagem = XFile('').obs;
  var todos = List<Todo>.empty().obs;

  @override
  void onInit() {
    List? storedTodos = GetStorage().read<List>('todo');
    if (storedTodos != null) {
      todos = storedTodos.map((e) => Todo.fromJson(e)).toList().obs;
    }
    ever(todos, (_) {
      GetStorage().write('todo', todos.toList());
    });
    super.onInit();
  }

  void addTodo(BuildContext context) {
    DatabaseProvider.db.addTodo(Todo(
        text: textTodo.value,
        time: timeTodo.value.format(context),
        isImportant: isImportant.value ? 1 : 0,
        image: imagem.value.path));
  }

  Future<List<Todo>> getTodos() async {
    return await DatabaseProvider.db.getTodos();
  }
}
