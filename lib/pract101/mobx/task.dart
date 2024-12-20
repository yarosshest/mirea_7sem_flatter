class Task {
  final String description;
  final bool isCompleted;

  Task({required this.description, this.isCompleted = false});

  Task copyWith({String? description, bool? isCompleted}) {
    return Task(
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
