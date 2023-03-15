import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rhitmo_list/controllers/database_provider.dart';
import 'package:rhitmo_list/controllers/notification_controller.dart';

import '../models/todo.dart';

class TodoController extends GetxController {
  var textTodo = ''.obs;
  var idTodo = 0.obs;
  var timeClicked = false.obs;
  var timeTodo = TimeOfDay.now().obs;
  var isImportant = false.obs;
  var imagem = XFile('').obs;
  var todos = List<Todo>.empty().obs;

  @override
  void onInit() async {
    todos.value = await getTodos();
    ever(todos, (_) {
      GetStorage().write('todo', todos.toList());
    });
    super.onInit();
  }

  void clearObs() {
    textTodo = ''.obs;
    idTodo = 0.obs;
    timeClicked = false.obs;
    timeTodo = TimeOfDay.now().obs;
    isImportant = false.obs;
    imagem = XFile('').obs;
  }

  void addTodo(BuildContext context) async {
    idTodo.value = await DatabaseProvider.db.addTodo(Todo(
      text: textTodo.value,
      time: timeTodo.value.format(context),
      isImportant: isImportant.value ? 1 : 0,
      image: imagem.value.path,
    ));
  }

  Future<List<Todo>> getTodos() async {
    return await DatabaseProvider.db.getTodos();
  }

  void updateTodo(int index, BuildContext context) async {
    DatabaseProvider.db.updateTodo(
        index + 1,
        textTodo.value,
        timeTodo.value.format(context),
        isImportant.value ? 1 : 0,
        imagem.value.path);
  }

  void deleteTodo(int index) {
    DatabaseProvider.db.deleteTodo(index + 1);
  }
}
