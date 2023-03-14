import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rhitmo_list/ui/widgets/text_form_widget.dart';

import '../controllers/todo_controller.dart';
import '../models/todo.dart';
import '../utils/button_styles.dart';

class AddTodoPage extends StatelessWidget {
  static const id = '/add_todo_page';
  final TodoController todoController = Get.put(TodoController());
  final _formKey = GlobalKey<FormState>();

  AddTodoPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Todo? todoToEdit = Get.arguments[0];
    if (todoToEdit != null) {
      todoController.textTodo.value = todoToEdit.text!;
      todoController.timeTodo.value = TimeOfDay(
          hour: int.parse(todoToEdit.time!.split(":")[0]),
          minute: int.parse(todoToEdit.time!.split(":")[1]));
      todoController.timeClicked.value = true;
      todoController.isImportant.value =
          todoToEdit.isImportant == 1 ? true : false;
      todoController.imagem.value = XFile(todoToEdit.image!);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar tarefa'),
      ),
      resizeToAvoidBottomInset: false,
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextFormWidget(
                  label: 'Título',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira um texto';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    todoController.textTodo.value = value;
                  },
                  initialValue: todoController.textTodo.value,
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: datePickerButtonStyle,
                      onPressed: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) {
                          todoController.timeClicked.value = true;
                          todoController.timeTodo.value = value!;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            Icons.alarm_outlined,
                            color: Colors.grey,
                          ),
                          Obx(
                            () => Text(
                              todoController.timeClicked.value
                                  ? todoController.timeTodo.value
                                      .format(context)
                                  : '--:--',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          )
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: datePickerButtonStyle,
                      onPressed: () async {
                        todoController.imagem.value = (await ImagePicker()
                            .pickImage(source: ImageSource.gallery))!;
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(
                            Icons.image_outlined,
                            color: Colors.grey,
                          ),
                          Text(
                            'Add Imagem',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => Align(
                    alignment: Alignment.center,
                    child: CheckboxListTile(
                      value: todoController.isImportant.value,
                      onChanged: (value) {
                        todoController.isImportant.value = value!;
                      },
                      title: const Text('Importante!'),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                ),
                Obx(
                  () => todoController.imagem.value.path.isNotEmpty
                      ? SizedBox(
                          height: 300,
                          child: Image.file(
                              File(todoController.imagem.value.path)),
                        )
                      : Container(),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (todoToEdit != null) {
                          todoController.todos[Get.arguments[1]] = Todo(
                            text: todoController.textTodo.value,
                            time: todoController.timeTodo.value.format(context),
                            isImportant:
                                todoController.isImportant.value ? 1 : 0,
                            image: todoController.imagem.value.path,
                          );
                          todoController.updateTodo(Get.arguments[1], context);
                        } else {
                          todoController.todos.add(
                            Todo(
                              text: todoController.textTodo.value,
                              time:
                                  todoController.timeTodo.value.format(context),
                              isImportant:
                                  todoController.isImportant.value ? 1 : 0,
                              image: todoController.imagem.value.path,
                            ),
                          );
                          todoController.addTodo(context);
                        }

                        todoController.clearObs();
                        Get.back();
                      }
                    },
                    style: filledButtonLargeStyle,
                    child: const Text('Salvar'),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
