class Project {
  String id;
  String title;
  String description;
  String userId; // ID пользователя, который создал проект

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'userId': userId,
    };
  }

  static Project fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      userId: map['userId'],
    );
  }
}
