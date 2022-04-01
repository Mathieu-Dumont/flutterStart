import 'package:firstapp/pages/TodoListPage.dart';
import 'package:firstapp/providers/TodoListModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String codeDialog = '';
  String valueText = '';

  Future<void> _addList(context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text('Voulez vous vraiment suprimer la liste ?'),
              content: Flexible(
                  child: TextFormField(
                autofocus: true,
                initialValue: '',
                onChanged: (value) {
                  valueText = value;
                },
                decoration:
                    const InputDecoration(hintText: "Text Field in Dialog"),
              )),
              actions: <Widget>[
                FlatButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Consumer<TodoListModel>(builder: (context, todoList, child) {
                  return FlatButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    child: const Text('YES'),
                    onPressed: () {
                      todoList.addNewList(valueText);
                      Navigator.pop(context);
                    },
                  );
                })
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todo lists'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15)),
                  onPressed: () {
                    _addList(context);
                  },
                  label: const Text('Add a new Todo list')),
            ),
            Consumer<TodoListModel>(builder: (context, todolist, child) {
              List<String> myLists = todolist.listNames;
              return ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: todolist.countList,
                  itemBuilder: (BuildContext context, int index) {
                    // access element from list using index
                    // you can create and return a widget of your choice
                    return ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/todos',
                              arguments: myLists[index]);
                        },
                        leading: const Icon(Icons.sports_motorsports),
                        title: Row(
                          children: [
                            Text(myLists[index]),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: (Text(
                                  "${todolist.countElement(myLists[index])}")),
                            ),
                          ],
                        ),
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
                                myLists.remove(index);
                              },
                            ),
                          ],
                        ));
                  });
            }),
          ],
        ));
  }
}
