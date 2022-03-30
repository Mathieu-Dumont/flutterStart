import 'package:firstapp/models/Todo.dart';
import 'package:firstapp/pages/TodoListPage.dart';
import 'package:firstapp/providers/TodoListModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo lists'),
      ),
      body: Consumer<TodoListModel>(builder: (context, todolist, child) {
        List<String> myLists = todolist.listNames;
        return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: todolist.countList,
            itemBuilder: (BuildContext context, int index) {
              // access element from list using index
              // you can create and return a widget of your choice
              return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const TodoListPage(title: 'todo')));
                  },
                  leading: const Icon(Icons.sports_motorsports),
                  title: Text(myLists[index]),
                  dense: false,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.create),
                        onPressed: () {
                          //_displayTextInputDialog(index);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          //todolist.remove(index);
                        },
                      ),
                    ],
                  ));
            });
      }),
    );
  }
}
