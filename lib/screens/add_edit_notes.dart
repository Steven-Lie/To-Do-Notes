import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddEditNotes extends StatelessWidget {
  const AddEditNotes(
      {super.key, this.title, this.noteValue, required this.isEdit, this.id});
  final bool isEdit;
  final String? id;
  final String? title;
  final String? noteValue;

  @override
  Widget build(BuildContext context) {
    CollectionReference notes = FirebaseFirestore.instance.collection('notes');

    TextEditingController titleController = title == null || title == "No Title"
        ? TextEditingController()
        : TextEditingController(text: title);
    TextEditingController noteController =
        noteValue == null || noteValue == "No Note"
            ? TextEditingController()
            : TextEditingController(text: noteValue);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: const Color(0xFF0058CA),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration.collapsed(
                  hintText: "Title",
                ),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: noteController,
                decoration: const InputDecoration.collapsed(
                  hintText: "Write your notes here",
                ),
                style: const TextStyle(
                  fontSize: 16,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (titleController.text == '' && noteController.text == '') {
            Navigator.pop(context);
          } else {
            if (isEdit) {
              notes.doc(id).update({
                'title': titleController.text == ''
                    ? 'No Title'
                    : titleController.text,
                'note':
                    noteController.text == '' ? 'No Note' : noteController.text,
                'created': Timestamp.now(),
              });
            } else {
              notes.add({
                'title': titleController.text == ''
                    ? 'No Title'
                    : titleController.text,
                'note':
                    noteController.text == '' ? 'No Note' : noteController.text,
                'created': Timestamp.now(),
              });
            }
            Navigator.pop(context);
          }
        },
        backgroundColor: const Color(0xFF0058CA),
        child: const Icon(Icons.save),
      ),
    );
  }
}
