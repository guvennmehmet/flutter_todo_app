import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../models/task_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
    );
  }
}

void _showAddTaskBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        width: MediaQuery.of(context).size.width,
        child: ListTile(
          title: TextField(
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
                    var yeniEklenecekGorev = Task.create(name: value, createdAt: time);
                });
              }
            },
          ),
        ),
      );
    },
  );
}
