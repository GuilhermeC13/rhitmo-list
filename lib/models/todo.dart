class Todo {
  int? id;
  String? text;
  int done;
  String? time;
  int isImportant;
  String? image;

  Todo({
    this.id,
    this.text,
    this.done = 0,
    this.isImportant = 0,
    this.time,
    this.image,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json['id'],
        text: json['text'],
        done: json['done'],
        isImportant: json['isImportant'],
        time: json['time'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'done': done,
        'isImportant': isImportant,
        'time': time,
        'image': image
      };
}
