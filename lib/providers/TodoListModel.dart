import 'package:flutter/widgets.dart';

class TodoListModel extends ChangeNotifier{
  List<String> _todos= List.empty(growable: true);

  get todo{
    return _todos;
  }

  addItem(String item){
    _todos.add(item);
    notifyListeners();
  }

  remove(int index){
    _todos.removeAt(index);
    notifyListeners();
  }

  clear(){
    _todos.clear();
    notifyListeners();
  }
}