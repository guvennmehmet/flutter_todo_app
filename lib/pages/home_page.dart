import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../models/task_model.dart';
import '../widgets/task_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Task> _allTasks;

  @override
  void initState() {
    _allTasks = <Task>[];
    _allTasks.add(Task.create(name: 'Deneme', createdAt: DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            _showAddTaskBottomSheet(context);
          },
          child: Text(
            'Bugün Neler Yapacaksın?',
            style: TextStyle(color: Colors.black),
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              _showAddTaskBottomSheet(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: _allTasks.isNotEmpty ? ListView.builder(
        itemBuilder: (context, index) {
          var _listeElemani = _allTasks[index];
          return Dismissible(
            background: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.delete,
                  color: Colors.grey,),
                SizedBox(
                  width: 8,
                ),
                Text('Bu görev silindi')
              ],
            ),
            key: Key(_listeElemani.id),
            onDismissed: (direction) {
              _allTasks.removeAt(index);
              setState(() {});
            },
              child: TaskItem(task: _listeElemani),
          );
        },
        itemCount: _allTasks.length,
      ) : Center(
        child: Text('Hadi görev ekle'),
      )
    );
  }
}

void _showAddTaskBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding:
        EdgeInsets.only(bottom: MediaQuery
            .of(context)
            .viewInsets
            .bottom),
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: ListTile(
          title: TextField(
            autofocus: true,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
              hintText: 'Görev Nedir?',
              border: InputBorder.none,
            ),
            onSubmitted: (value) {
              Navigator.of(context).pop();
              if (value.length > 3) {
                DatePicker.showTimePicker(context, showSecondsColumn: false,
                    onConfirm: (time) {
                      var yeniEklenecekGorev =
                      Task.create(name: value, createdAt: time);
                      _allTasks.add(yeniEklenecekGorev);
                      setState(() {

                      });
                    });
              }
            },
          ),
        ),
      );
    },
  );
}
