import 'package:equatable/equatable.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final String title;
  final String description;

  AddTask(this.title, this.description);

  @override
  List<Object?> get props => [title, description];
}
