import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhitmo_list/ui/add_todo_page.dart';

import '../controllers/todo_controller.dart';

class HomePage extends StatelessWidget {
  static const id = '/home_page';
  final TodoController todoController = Get.put(TodoController());

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rhitmo List'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          Get.toNamed(AddTodoPage.id);
        },
      ),
      body: Obx(
        () => ListView.builder(
          itemBuilder: (context, index) => Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.deepOrange,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (_) {
              todoController.todos.removeAt(index);
              Get.snackbar('Remove!', "Task was succesfully Delete",
                  snackPosition: SnackPosition.BOTTOM);
            },
            child: ListTile(
              title: Text(
                todoController.todos[index].text!,
                style: todoController.todos[index].done == 1
                    ? const TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough,
                      )
                    : const TextStyle(
                        color: Colors.black,
                      ),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
              ),
              leading: Checkbox(
                value: todoController.todos[index].done == 1 ? true : false,
                onChanged: (neWvalue) {
                  var todo = todoController.todos[index];
                  todo.done = neWvalue! == true ? 1 : 0;
                  todoController.todos[index] = todo;
                },
              ),
            ),
          ),
          itemCount: todoController.todos.length,
        ),
      ),
    );
  }
}
