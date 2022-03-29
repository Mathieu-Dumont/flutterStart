import 'package:firstapp/models/Todo.dart';
import 'package:firstapp/providers/TodoListModel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => TodoListModel(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String codeDialog = '';
  String valueText = '';

  Future<void> _confirmationClearList(context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text('Voulez vous vraiment suprimer la liste ?'),
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
                      todoList.clear();
                      Navigator.pop(context);
                    },
                  );
                })
              ]);
        });
  }

  Future<void> _displayTextInputDialog([int index = -1]) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('TextField in Dialog'),
            content:
                Consumer<TodoListModel>(builder: (context, todoList, child) {
              return Row(mainAxisSize: MainAxisSize.min, children: [
                Checkbox(
                    value: todoList.getItem(index).checked,
                    onChanged: (value) {
                      todoList.toggleCheck(index);
                    }),
                Flexible(
                    child: TextFormField(
                  autofocus: true,
                  initialValue:
                      (index == -1) ? '' : todoList.getItem(index).name,
                  onChanged: (value) {
                    valueText = value;
                  },
                  decoration:
                      const InputDecoration(hintText: "Text Field in Dialog"),
                ))
              ]);
            }),
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
                  child: const Text('OK'),
                  onPressed: () {
                    codeDialog = valueText;
                    if (codeDialog.isNotEmpty) {
                      todoList.insertOrUpdate(index, codeDialog);
                    }
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Consumer<TodoListModel>(builder: (context, todolist, child) {
          List<Todo> todos = todolist.todo;
          return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: todos.length,
              itemBuilder: (BuildContext context, int index) {
                // access element from list using index
                // you can create and return a widget of your choice
                return ListTile(
                    leading: Row(mainAxisSize: MainAxisSize.min, children: [
                      const Icon(Icons.sports_motorsports),
                      Checkbox(
                          value: todos[index].checked,
                          onChanged: (value) {
                            todolist.toggleCheck(index);
                          }),
                    ]),
                    title: Text(todos[index].name),
                    dense: false,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.create),
                          onPressed: () {
                            _displayTextInputDialog(index);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            todolist.remove(index);
                          },
                        ),
                      ],
                    ));
              });
        }),
        floatingActionButton: Stack(children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: FloatingActionButton(
                onPressed: _displayTextInputDialog,
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child:
                  Consumer<TodoListModel>(builder: (context, todoList, child) {
                return FloatingActionButton(
                    child: const Icon(Icons.clear),
                    onPressed: () {
                      _confirmationClearList(context);
                    });
              })),
        ]));
  }
}
