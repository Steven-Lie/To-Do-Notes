import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_notes/providers/date_time_provider.dart';

class AddEditToDo extends StatelessWidget {
  const AddEditToDo(
      {super.key,
      this.id,
      this.name,
      this.description,
      this.dateFormat,
      this.date,
      this.timeFormat,
      required this.isEdit});

  final bool isEdit;
  final String? id;
  final String? name;
  final String? description;
  final String? dateFormat;
  final String? date;
  final String? timeFormat;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController =
        isEdit ? TextEditingController(text: name) : TextEditingController();
    final descriptionController = isEdit
        ? TextEditingController(text: description)
        : TextEditingController();
    final dateController = isEdit
        ? TextEditingController(text: dateFormat)
        : TextEditingController();
    final timeController = isEdit
        ? TextEditingController(text: timeFormat)
        : TextEditingController();

    final dateTimeProvider =
        Provider.of<DateTimeProvider>(context, listen: false);
    dateTimeProvider.resetDateAndTime();

    if (isEdit) {
      if (date != '') {
        dateTimeProvider.editDate(DateTime.parse(date!));
      }
      if (timeFormat != '') {
        String hourMinute = timeFormat!.substring(0, 5);
        dateTimeProvider.editTime(
          TimeOfDay(
            hour: int.parse(hourMinute.split(':')[0]),
            minute: int.parse(hourMinute.split(":")[1]),
          ),
        );
      }
    }

    final localization = MaterialLocalizations.of(context);

    CollectionReference todos = FirebaseFirestore.instance.collection('todos');

    InputDecoration nameDescField = InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xFF0058CA),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.red,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xFF0058CA),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
    );

    InputDecoration dateTimeInput(IconData icon, String label) {
      return InputDecoration(
        suffixIcon: Icon(
          icon,
          color: const Color(0xFF0058CA),
        ),
        labelText: label,
        labelStyle: const TextStyle(
          color: Color(0xFF0058CA),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF0058CA),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF0058CA),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(4),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Edit Task" : "Add New Task"),
        backgroundColor: const Color(0xFF0058CA),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Task Name',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  validator: (value) => value == '' ? "Don't Empty" : null,
                  controller: nameController,
                  cursorColor: const Color(0xFF0058CA),
                  decoration: nameDescField,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Task Description',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: descriptionController,
                  cursorColor: const Color(0xFF0058CA),
                  decoration: nameDescField,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                const SizedBox(
                  height: 16,
                ),
                Consumer<DateTimeProvider>(
                  builder: (context, value, child) => TextFormField(
                    controller: dateController,
                    decoration:
                        dateTimeInput(Icons.date_range_rounded, 'Due Date'),
                    readOnly: true,
                    onTap: () async {
                      DateTime? datePicked = await showDatePicker(
                        context: context,
                        initialDate: dateTimeProvider.date,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );

                      if (datePicked != null) {
                        dateTimeProvider.datePicked(datePicked);
                        dateController.text = DateFormat.yMMMd('en_US')
                            .format(dateTimeProvider.date)
                            .toString();
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Consumer<DateTimeProvider>(
                  builder: (context, value, child) => TextFormField(
                    controller: timeController,
                    decoration: dateTimeInput(Icons.access_time, 'Due Time'),
                    readOnly: true,
                    onTap: () async {
                      TimeOfDay? timePicked = await showTimePicker(
                        context: context,
                        initialTime: dateTimeProvider.time,
                      );

                      if (timePicked != null) {
                        dateTimeProvider.timePicked(timePicked);
                        timeController.text =
                            localization.formatTimeOfDay(dateTimeProvider.time);
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: ElevatedButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (formKey.currentState!.validate()) {
                        if (isEdit) {
                          todos.doc(id).update({
                            'name': nameController.text,
                            'description': descriptionController.text,
                            'dueDate': dateTimeProvider.date.toString(),
                            'dueDateFormat': dateController.text,
                            'dueTimeFormat': timeController.text,
                            'created': Timestamp.now(),
                          });
                        } else {
                          todos.add({
                            'name': nameController.text,
                            'description': descriptionController.text,
                            'dueDate': dateTimeProvider.date.toString(),
                            'dueDateFormat': dateController.text,
                            'dueTimeFormat': timeController.text,
                            'created': Timestamp.now(),
                          });
                        }

                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0058CA),
                      minimumSize: const Size.fromHeight(40),
                      shape: const StadiumBorder(),
                    ),
                    child: const Text('Confirm'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
