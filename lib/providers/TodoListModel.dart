import 'package:firstapp/models/Todo.dart';
import 'package:flutter/widgets.dart';

class TodoListModel extends ChangeNotifier {
  List<Todo> _todos = List.empty(growable: true);

  get todo {
    return _todos;
  }

  addItem(String item) {
    _todos.add(Todo(name: item, checked: false));
    notifyListeners();
  }

  Todo getItem(int index) {
    if (index == -1) {
      return Todo(name: '');
    }
    return _todos.elementAt(index);
  }

  toggleCheck(int index) {
    if (index != -1) {
      _todos[index].checked = !_todos[index].checked;
      notifyListeners();
    }
  }

  update(int index, String newValue) {
    _todos[index].name = newValue;
    notifyListeners();
  }

  insertOrUpdate(int index, String newValue) {
    if (index == -1) {
      addItem(newValue);
    } else {
      update(index, newValue);
    }
  }

  remove(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }

  clear() {
    _todos.clear();
    notifyListeners();
  }
}
