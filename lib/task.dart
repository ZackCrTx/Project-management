class Task {
  String id;
  String projectId;
  String title;
  String status;
  String description; // Поле для описания задачи

  Task({
    required this.id,
    required this.projectId,
    required this.title,
    required this.status,
    required this.description, // Добавляем описание
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'projectId': projectId,
      'title': title,
      'status': status,
      'description': description,
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      projectId: map['projectId'],
      title: map['title'],
      status: map['status'],
      description: map['description'],
    );
  }
}
