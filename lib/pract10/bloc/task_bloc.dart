import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirea_7sem_flatter/pract10/api/tasks.dart';
import 'events.dart';
import 'states.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskApi taskApi;

  TaskBloc(this.taskApi) : super(TaskInitial()) {
    on<FetchTasks>(_onFetchTasks);
    on<AddTask>(_onAddTask);
  }

  Future<void> _onFetchTasks(FetchTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = await taskApi.fetchTasks();
      emit(TaskLoaded(tasks.cast<Task>()));
    } catch (error) {
      emit(TaskError('Failed to fetch tasks: $error'));
    }
  }

  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    try {
      await taskApi.addTaskRequest(event.title, event.description);
      add(FetchTasks()); // Перезагрузка списка задач
    } catch (error) {
      emit(TaskError('Failed to add task: $error'));
    }
  }
}
