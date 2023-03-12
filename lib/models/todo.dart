import 'dart:ffi';

class Todo {
  String? text;
  int done;
  String? time;
  int isImportant;
  String? image;

  Todo({
    this.text,
    this.done = 0,
    this.isImportant = 0,
    this.time,
    this.image,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        text: json['text'],
        done: json['done'],
        isImportant: json['isImportant'],
        time: json['time'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'done': done,
        'isImportant': isImportant,
        'time': time,
        'image': image
      };
}
