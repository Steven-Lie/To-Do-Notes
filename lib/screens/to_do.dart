import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_notes/screens/add_edit_to_do.dart';

class ToDo extends StatelessWidget {
  const ToDo({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference todos = FirebaseFirestore.instance.collection('todos');

    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do'),
        backgroundColor: const Color(0xFF0058CA),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<QuerySnapshot>(
          stream: todos.orderBy('created', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data!.docs.map((todo) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddEditToDo(
                            isEdit: true,
                            id: todo.id,
                            name: todo['name'],
                            description: todo['description'],
                            dateFormat: todo['dueDateFormat'],
                            date: todo['dueDate'],
                            timeFormat: todo['dueTimeFormat'],
                          ),
                        ),
                      );
                    },
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              todos.doc(todo.id).delete();
                            },
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          )
                        ],
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Card(
                          borderOnForeground: false,
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                dateTime(todo),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  todo['name'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  todo['description'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddEditToDo(
              isEdit: false,
            ),
          ),
        ),
        backgroundColor: const Color(0xFF0058CA),
        child: const Icon(Icons.add),
      ),
    );
  }

  Text dateTime(QueryDocumentSnapshot todo) {
    if (todo['dueDateFormat'] != '' && todo['dueTimeFormat'] != '') {
      return Text(
        "${todo['dueDateFormat']} | ${todo['dueTimeFormat']}",
        style: const TextStyle(
          fontSize: 14,
        ),
      );
    } else if (todo['dueDateFormat'] != '') {
      return Text(
        "${todo['dueDateFormat']}",
        style: const TextStyle(
          fontSize: 14,
        ),
      );
    } else if (todo['dueTimeFormat'] != '') {
      return Text(
        "${todo['dueTimeFormat']}",
        style: const TextStyle(
          fontSize: 14,
        ),
      );
    } else {
      return const Text(
        "No due date and due time",
        style: TextStyle(
          fontSize: 14,
        ),
      );
    }
  }
}
