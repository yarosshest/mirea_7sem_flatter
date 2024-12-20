import 'package:equatable/equatable.dart';
import 'package:mirea_7sem_flatter/pract10/api/tasks.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  TaskLoaded(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

class TaskError extends TaskState {
  final String message;

  TaskError(this.message);

  @override
  List<Object?> get props => [message];
}
