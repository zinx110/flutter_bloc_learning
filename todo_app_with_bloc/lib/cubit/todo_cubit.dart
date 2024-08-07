import "package:flutter_bloc/flutter_bloc.dart";
import "package:todo_app/models/todo_model.dart";

class TodoCubit extends Cubit<List<Todo>> {
  TodoCubit() : super([]);

  void addTodo(String title) {
    if (title.isEmpty) {
      addError("Title is empty");

      return;
    }
    final todo = Todo(name: title, createdAt: DateTime.now());

    emit([...state, todo]);
  }

  void removeTodo(String title) {
    state.removeWhere((todo) => todo.name == title);

    emit([...state]);
  }

  @override
  void onChange(Change<List<Todo>> change) {
    super.onChange(change);
    print("Todo Cubit - $change");
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // TODO: implement onError
    super.onError(error, stackTrace);
    print(error.toString());
  }
}
